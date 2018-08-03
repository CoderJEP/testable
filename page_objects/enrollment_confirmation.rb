# frozen_string_literal: true
require_relative 'base_page'

module PageObjects
  class EnrollmentConfirmation < BasePage
    def self.view_course_curriculum
      raise 'EnrollmentConfirmation::continue() is not defined'
    end
  end
end
