
class LoginsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client
  before_action :set_login_id, only: %i(refresh reconnect destroy)

  def show
    @id = params[:id]
    @login = @client.request("GET", "logins/#{@id}", {})
    @login = @login[:response]['data']
  end

  def index
    @logins = @client.request("GET", "logins", {})
    @logins = @logins[:response]['data']
  end

  def token
    @customer_id = params[:customer_id]
    @data = { customer_id: @customer_id, return_to: root_url , fetch_scopes: [ "accounts", "transactions" ] }
    @token = @client.request("POST", "tokens/create", {data: @data})
    redirect_to @token[:response]['data']['connect_url']
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
    @data = @client.request("DELETE", "logins/#{@id}", {})
    render json: { data: @data[:response] }, status: @data[:status]
  end

  private

  def call_api(path)
    @data = { login_id: @id, return_to: logins_url, fetch_scopes: [ "accounts", "transactions" ] }
    @response = @client.request("POST", "tokens/#{path}", {data: @data})
  end

  def set_client
    @client = Saltedge.new
  end

  def set_login_id
    @id = params[:login_id]
  end
end
