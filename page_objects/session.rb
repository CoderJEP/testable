# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Session
    def self.keep
      page.instance_variable_set(:@touched, false)
    end
  end
end
