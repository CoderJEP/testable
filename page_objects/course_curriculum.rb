# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class CourseCurriculum
    def self.wait_for_ready
      page.has_content?('Class Curriculum')
    end

    def self.percent_complete
      wait_for_ready
      find('.percentage').text
    end

    def self.lectures
      wait_for_ready
      all('.lecture-name').map(&:text)
    end

    def self.start
      click_link 'Start next lecture'
      page.has_no_content?('Class Curriculum')
    end

    def self.return_to_courses
      find('.nav-icon-back').click
    end
  end
end
