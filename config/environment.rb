# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dursty::Application.initialize!

# initialize ActionMailer
ActionMailer::Base.delivery_method = :smtp
