module ArtikelHelper
  def check_role *roles
    roles.each do |r|
      return if current_user[r]
    end

    redirect_to root_path
  end
end
