class UsersController < ApplicationController
	 skip_before_action :authenticate_request, :only => [:create]

	def show
		
			user = User.where(activate_account: true, id: params[:id])
			if user.any?
				render json: {user: user}
			else
				render json: {error: "utilisateur inconnu"}, status: :no_content
			end
	end
	def update
		user = User.find(params[:id])
		if user.any?
			if params.has_key?(:activate_account)
				user.activate_account =  params[:activate_account]
			end
			if params.has_key?(:name)
				user.name =  params[:name]
			end
			if params.has_key?(:nickname)
					user.nickname =  params[:nickname]
			end
			if params.has_key?(:surname)
					user.surname =  params[:surname]
			end
			if params.has_key?(:password) && params.has_key?(:password_confirmation)
					user.password =  params[:password]
			end
			begin 
					user.save
					render json: {message: "ok"}, status: :ok
			rescue
				render json: {error: user.errors}, status: :bad_request
			end
		else
			render json: {error: "utilisateur inconnu"}, status: :no_content
		end	
	end
	def create
		user = User.new(email: params[:email],name:  params[:name], surname: params[:surname], nickname: params[:nickname], password: params[:password], password_confirmation: params[:password], activate_account: false, dob: params[:dob])
		if user.valid?
			user.save
			render json: {message: "ok"}, status: :ok
		else
			render json: {error: user.errors}, status: :bad_request
		end

	end
	def destroy
		user = User.find(params[:id])
		user.activate_account = false
		user.save
	end




end