class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_spectre!

  def index
    @login_id = params[:login_id]
    @account_id = params[:account_id]
    @transactions = api_callback("GET", "transactions?account_id=#{@account_id}", {})
    @transactions = get_data(@transactions)
  end
end
