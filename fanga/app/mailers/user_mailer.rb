
class UserMailer < ApplicationMailer

  def send_token_creation(user, token)
    @user = user
    @token = token
    @url = "#{ENV['ROOT_URL_FRONT']}/user/validate_user/#{@user.id}/#{@token.token_string}"
     mail(to: @user.email, subject: 'Welcome to liftair, validate your subscription')
  end
  
end
