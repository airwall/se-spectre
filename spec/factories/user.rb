FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password "12345678"
    password_confirmation "12345678"
    spectre_active true
  end
end
