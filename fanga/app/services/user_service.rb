class UserService
  def self.checkAccount(token, user_id) 
    if Token.where({user_id: user_id, token_string: token}).count()> 0
      return true
    end
    return false
  end
  
end