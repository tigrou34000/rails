class UsersController < ApplicationController
	 skip_before_action :authenticate_request, :only => [:create]

	def show
		
			user = User.where( id: @current_user.id)
			if user.any?
				render json: {user: user}
			else
				render json: {error: "utilisateur inconnu"}, status: :no_content
			end
	end
	def update
		user = User.find(params[:id])


		if !user.nil?
			puts("user exist")

			if params.has_key?(:activate_account)
				user.activate_account =  params[:activate_account]
			end
			if params.has_key?(:name)
				puts("name should be save")
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
				user.password_confirmation =  params[:password_confirmation]
			end
			if user.valid?
				user.save
				render json: {message: "ok"}, status: :ok
			else
				render json: {error: user.errors}, status: :bad_request
			end
		else
			render json: {error: "utilisateur inconnu"}, status: :no_content
		end	
	end
	def create
		user = User.new(email: params[:email],name:  params[:name], surname: params[:surname], nickname: params[:nickname], password_digest: params[:password], activate_account: false, dob: params[:dob])
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