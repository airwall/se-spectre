class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_customer

  private

  def create_customer
    Customer.delay.create(email)
  end
end
