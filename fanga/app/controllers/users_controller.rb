class UsersController < ApplicationController
	 skip_before_action :authenticate_request, :only => [:create]


	 swagger_path '/users/{id}' do
	    operation :get do
	      key :summary, 'Find user by ID'
	      key :description, 'Returns a single user if the user has access'
	      key :operationId, 'findUserById'
	      key :tags, [
	        'user'
	      ]
	      parameter do
	        key :name, :id
	        key :in, :path
	        key :description, 'ID of user to fetch'
	        key :required, true
	        key :type, :integer
	        key :format, :int64
	      end
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def show
			user = User.where( id: @current_user.id)
			if user.any?
				render json: {user: user}
			else
				render json: {error: "utilisateur inconnu"}, status: :no_content
			end
	end


 	swagger_path '/users/{id}' do
	    operation :put do
	      key :summary, 'update user by ID'
	      key :description, 'update single user if the user has access'
	      key :operationId, 'updateUserById'
	      key :tags, [
	        'user'
	      ]
	      parameter do
	        key :name, :id
	        key :in, :path
	        key :description, 'ID of user to update'
	        key :required, true
	        key :type, :integer
	        key :format, :int64
	      end
	       parameter do
	        key :name, :user
	        key :in, :body
	        key :description, 'must content at least one of  active_user , name, nickname, surname, password and password_confirmation'
	        key :required, false
	        key :type, :string
	      end
	      response 200 do
	        key :description, 'user response'
	      end
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

	swagger_path '/users/' do
	    operation :post do
	      key :summary, 'create user by ID'
	      key :description, 'create single user if the user has access'
	      key :operationId, 'createUserById'
	      key :tags, [
	        'user'
	      ]
	     parameter do
	        key :name, :activate_account
	        key :in, :body
	        key :description, 'must content at least one of  active_user , name, nickname, surname, password and password_confirmation'
	        key :required, true
	        key :type, :string
	      end
	      response 200 do
	        key :description, 'user response'
	      end
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

 	swagger_path '/users/{id}' do
	    operation :delete do
	      key :summary, 'delete user by ID'
	      key :description, 'delete single user if the user has access'
	      key :operationId, 'DeleteUserById'
	      key :tags, [
	        'user'
	      ]
	      parameter do
	        key :name, :id
	        key :in, :path
	        key :description, 'ID of user to fetch'
	        key :required, true
	        key :type, :integer
	        key :format, :int64
	      end
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def destroy
		user = User.find(params[:id])
		user.activate_account = false
		user.save
	end
end