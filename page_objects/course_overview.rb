# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class CourseOverview
    ENROLLMENT = '#enroll-button-top'

    def self.enroll
      find(ENROLLMENT).click
    end

    def self.enrollment_cost
      find(ENROLLMENT).text.downcase.split(' ').last
    end
  end
end
