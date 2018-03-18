class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_spectre!

  def index
    @login_id = params[:login_id]
    params = set_params(@login_id)
    @accounts = api_callback("GET", "accounts#{params}", {})
    @accounts = get_data(@accounts)
  end

  private

  def set_params(login_id)
    login_id.nil? ? "" : "?login_id=#{login_id}"
  end
end
