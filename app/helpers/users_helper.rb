module UsersHelper

  # Return the first part of the user email (before the @ sign)
  def short_email(user)
    user.email.split('@').first
  end

end
