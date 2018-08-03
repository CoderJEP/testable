# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class CourseCurriculum
    PAGE_LABEL   = 'Class Curriculum'
    PERCENTAGE   = '.percentage'
    LECTURE_NAME = '.lecture-name'
    START        = 'Start next lecture'
    BACK         = '.nav-icon-back'

    def self.wait_for_ready
      page.has_content?(PAGE_LABEL)
    end

    def self.percent_complete
      wait_for_ready
      find(PERCENTAGE).text
    end

    def self.lectures
      wait_for_ready
      all(LECTURE_NAME).map(&:text)
    end

    def self.start
      click_link START
      page.has_no_content?(PAGE_LABEL)
    end

    def self.return_to_courses
      find(BACK).click
    end
  end
end
