# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Home
    def self.go
      visit 'http://takehome.zeachable.com'
    end

    def self.enroll
      click_link 'Enroll Now'
    end
  end
end
