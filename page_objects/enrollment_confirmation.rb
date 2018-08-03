# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class EnrollmentConfirmation
    def self.wait_for_ready
      page.has_content?('Your order ID')
    end

    def self.order_id
      wait_for_ready
      find('p', { text: 'Your order ID' }).text.split(' ').last
    end

    def self.confirmation_email
      wait_for_ready
      find('p', { text: 'email confirmation at' }).text.split(' ').last
    end

    def self.continue
      click_link 'Continue to Course'
    end
  end
end
