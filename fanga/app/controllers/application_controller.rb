class ApplicationController < ActionController::API
	before_action :authenticate_request
 	before_action :set_locale
 
 
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

   def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
