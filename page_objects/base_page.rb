# frozen_string_literal: true
require 'selenium-webdriver'

module PageObjects
  class BasePage
    # TODO: Clean this up
    @@driver = Selenium::WebDriver.for :chrome # rubocop:disable Style/ClassVars

    def self.quit
      @@driver.quit
    end
  end
end
