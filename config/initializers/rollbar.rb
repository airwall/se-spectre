Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_TOKEN'] if !Rails.env.test?
end
