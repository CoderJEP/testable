# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Courses
    COURSE_TITLE = '.course-listing-title'
    SEARCH_TEXT  = 'Search-courses'
    SEARCH       = 'search-course-button'

    def self.view_course(course_name)
      unless find(COURSE_TITLE) { |c| c.text == course_name }
        fill_in SEARCH_TEXT, { with: course_name }
        click_button SEARCH
      end

      page.find(COURSE_TITLE).has_content?(course_name)

      find(COURSE_TITLE) { |c| c.text == course_name }.click
    end
  end
end
