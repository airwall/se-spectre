class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authenticate_spectre!
    unless current_user.spectre_active
      redirect_to controller: :customers, action: :activate
    end
  end
end
