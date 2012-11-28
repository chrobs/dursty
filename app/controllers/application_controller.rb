# encoding: UTF-8
require 'will_paginate/array'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthHelper
end
