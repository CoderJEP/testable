# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class EnrollmentConfirmation
    ORDER_ID_LABEL           = 'Your order ID'
    EMAIL_CONFIRMATION_LABEL = 'email confirmation at'
    CONTINUE                 = 'Continue to Course'

    def self.wait_for_ready
      page.has_content?(ORDER_ID_LABEL)
    end

    def self.order_id
      wait_for_ready
      find('p', { text: ORDER_ID_LABEL }).text.split(' ').last
    end

    def self.confirmation_email
      wait_for_ready
      find('p', { text: EMAIL_CONFIRMATION_LABEL }).text.split(' ').last
    end

    def self.continue
      click_link CONTINUE
    end
  end
end
