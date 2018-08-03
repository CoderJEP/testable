# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Lecture
    NEXT       = '.next-lecture'
    PERCENTAGE = '.percentage'
    TEXTS      = '.lecture-text-container'
    PDFS       = '.attachment-pdf-embed'
    VIDEOS     = '.wistia_embed'
    DOWNLOADS  = '.download'
    COMPLETE   = '#lecture_complete_button'

    def self.wait_for_ready(lecture_name, expected_percent_complete)
      find(NEXT).has_content?(lecture_name)

      find(PERCENTAGE).has_content?(expected_percent_complete)
    end

    def self.percent_complete
      find(PERCENTAGE).text
    end

    # TODO: This should be methods to return the information. Since we are not asserting it yet, let's just print for debugging.
    def self.print_content(lecture_index, lecture_name)
      text      = all(TEXTS).map(&:text)
      pdfs      = all(PDFS)
      videos    = all(VIDEOS)
      downloads = all(DOWNLOADS)

      puts '---------------------------------'
      puts "Lecture #{lecture_index} `#{lecture_name}` contains:"
      puts "The following text:\n #{text.join('\n')}" unless text.count.zero?
      puts "The following pdfs:\n #{pdfs.map(&:text).join('\n')}" unless pdfs.count.zero?
      puts "The following downloads:\n #{downloads.map(&:text).join('\n')}" unless downloads.count.zero?
      puts "#{videos.count} video(s)" unless videos.count.zero?
      puts "---------------------------------\n"
    end

    def self.next
      find(COMPLETE).click
    end
  end
end
