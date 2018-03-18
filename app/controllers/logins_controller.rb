
class LoginsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client
  before_action :set_login_id, only: %i(refresh reconnect destroy)

  def show
    @id = params[:id]
    @login = api_callback("GET", "logins/#{@id}", {})
    @login = get_data(@login)
  end

  def index
    @logins = api_callback("GET", "logins", {})
    @logins = get_data(@logins)
  end

  def token
    @customer_id = params[:customer_id]
    @data = { customer_id: @customer_id, return_to: root_url , fetch_scopes: [ "accounts", "transactions" ] }
    @token = api_callback("POST", "tokens/create", {data: @data})
    redirect_to get_data(@token)['connect_url']
  end

  def refresh
    call_api('refresh')
    redirect_to @response[:response]['data']['connect_url']
  end

  def reconnect
    call_api('reconnect')
    redirect_to @response[:response]['data']['connect_url']
  end

  def destroy
    @data = api_callback("DELETE", "logins/#{@id}", {})
    render json: { data: @data[:response] }, status: @data[:status]
  end

  private

  def call_api(path)
    @data = { login_id: @id, return_to: logins_url, fetch_scopes: [ "accounts", "transactions" ] }
    @response =  api_callback("POST", "tokens/#{path}", {data: @data})
  end

  def set_client
    @client = Saltedge.new
  end

  def set_login_id
    @id = params[:login_id]
  end
end
