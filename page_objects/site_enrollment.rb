# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class SiteEnrollment
    def self.signup(user)
      fill_in 'Full Name', { with: user.name }
      fill_in 'Email Address', { with: user.email }
      fill_in 'Password', { with: user.password }
      fill_in 'Confirm Password', { with: user.password }
      find('#user_unsubscribe_from_marketing_emails').click
      find('#user_agreed_to_terms').click
      click_button 'Sign Up'
    end
  end
end
