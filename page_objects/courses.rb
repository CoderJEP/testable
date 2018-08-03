# frozen_string_literal: true
require_relative 'base_page'

module PageObjects
  class Courses < BasePage
    def self.view_course
      raise 'Courses::view_course() is not defined'
    end
  end
end
