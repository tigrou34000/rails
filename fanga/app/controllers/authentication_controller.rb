class AuthenticationController < ApplicationController

  	skip_before_action :authenticate_request

     swagger_path '/authentication/' do
	    operation :get do
	      key :summary, 'lists towns by ID'
	      key :description, 'Returns all  town if the user has access'
	      key :operationId, 'authenticate'
	      key :tags, [
	        'authentication'
	      ]
	      parameter do
	        key :name, :email
	        key :in, :query
	        key :description, 'email'
	        key :required, true
	        key :type, :string
	      end
	       parameter do
	        key :name, :password
	        key :in, :query
	        key :description, 'password'
	        key :required, true
	        key :type, :string
	      end
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def authenticate
		command = AuthenticateUser.call(params[:email], params[:password])

		if command.success?
		  render json: { auth_token: command.result, user_id: JsonWebToken.decode(command.result)['user_id'] }
		else
		  render json: { error: command.errors }, status: :unauthorized
		end
	end
end