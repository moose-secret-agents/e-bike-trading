class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def edit?
    is_current_user?
  end

  def destroy?
    is_current_user?
  end

  private
    def is_current_user?
      @current_user == user
    end
end