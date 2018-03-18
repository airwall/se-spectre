class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def bad_request; end

  private

  def api_callback(method, path, params)
    client = Saltedge.new
    data = client.request(method, path, params)
    unless data[:status] == 200
      flash[:error] = data[:response]["error_message"]
      redirect_to oops_path
    end
    data
  end

  def get_data(data)
    data[:response]["data"]
  end

  def authenticate_spectre!
    unless current_user.spectre_active
      redirect_to controller: :customers, action: :activate
    end
  end
end
