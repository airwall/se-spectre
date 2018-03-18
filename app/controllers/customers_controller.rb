class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_spectre!, except: :activate
  before_action :set_client

  def index
    @customers = @client.request("GET", "customers", {})
    @customers = @customers[:response]['data']
  end

  def activate
    @active = false
    if is_spectre_active?
      redirect_to root_path
    else
      @active = current_user.activate_spectre!
      if @active
        redirect_to root_path
      else
        @active = false
        flash[:notice] = "Something it's wrong. PLease try later!"
        render :activate
      end
    end
  end

  private

  def is_spectre_active?
    current_user.spectre_active?
  end

  def set_client
    @client = Saltedge.new
  end
end
