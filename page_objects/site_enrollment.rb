# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class SiteEnrollment
    WAIT_TIME        = 10
    NAME             = 'Full Name'
    EMAIL            = 'Email Address'
    PASSWORD         = 'Password'
    CONFIRM_PASSWORD = 'Confirm Password'
    UNSUBSCRIBE      = '#user_unsubscribe_from_marketing_emails'
    TERMS            = '#user_agreed_to_terms'
    SIGN_UP          = 'Sign Up'

    def self.sign_up(user)
      original_wait_time             = Capybara.default_max_wait_time
      Capybara.default_max_wait_time = WAIT_TIME

      fill_in NAME, { with: user.name }
      fill_in EMAIL, { with: user.email }
      fill_in PASSWORD, { with: user.password }
      fill_in CONFIRM_PASSWORD, { with: user.password }
      find(UNSUBSCRIBE).click
      find(TERMS).click
      click_button SIGN_UP

      Capybara.default_max_wait_time = original_wait_time
    end
  end
end
