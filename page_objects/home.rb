# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Home
    URL    = 'http://takehome.zeachable.com'
    ENROLL = 'Enroll Now'

    def self.go
      visit URL
    end

    def self.enroll
      click_link ENROLL
    end
  end
end
