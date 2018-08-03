# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class CourseOverview
    def self.enrollment_button
      find('#enroll-button-top')
    end

    def self.enroll
      enrollment_button.click
    end

    def self.enrollment_cost
      enrollment_button.text.downcase.split(' ').last
    end
  end
end
