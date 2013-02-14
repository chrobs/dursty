# encoding: UTF-8
require 'will_paginate/array'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthHelper

  before_filter do
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end
end
