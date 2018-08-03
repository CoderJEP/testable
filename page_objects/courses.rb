# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Courses
    def self.view_course(course_name)
      unless find('.course-listing-title') { |c| c.text == course_name }
        fill_in 'search-courses', { with: course_name }
        click_button 'search-course-button'
      end

      page.find('.course-listing-title').has_content?(course_name)

      find('.course-listing-title') { |c| c.text == course_name }.click
    end
  end
end
