require_relative '../helpers/application_helper.rb'
require 'json'
require 'rest-client'

class ApplicationService
  include ApplicationHelper

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
