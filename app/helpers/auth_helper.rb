module AuthHelper
  def check_role *roles
    roles.each do |r|
      return true if current_user[r]
    end

    return false
  end
end
