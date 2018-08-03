# frozen_string_literal: true
require_relative 'page_object_helper'

include Capybara::DSL

module PageObjects
  class Lecture
    def self.wait_for_ready(lecture_name, expected_percent_complete)
      find('.next-lecture').has_content?(lecture_name)

      find('.percentage').has_content?(expected_percent_complete)
    end

    def self.percent_complete
      find('.percentage').text
    end

    # TODO: This should be methods to return the information. Since we are not asserting it yet, let's just print for debugging.
    def self.print_content(lecture_index, lecture_name)
      text      = all('.lecture-text-container').map(&:text)
      pdfs      = all('.attachment-pdf-embed')
      videos    = all('.wistia_embed')
      downloads = all('.download')

      puts '---------------------------------'
      puts "Lecture #{lecture_index} `#{lecture_name}` contains:"
      puts "The following text:\n #{text.join('\n')}" unless text.count.zero?
      puts "The following pdfs:\n #{pdfs.map(&:text).join('\n')}" unless pdfs.count.zero?
      puts "The following downloads:\n #{downloads.map(&:text).join('\n')}" unless downloads.count.zero?
      puts "#{videos.count} video(s)" unless videos.count.zero?
      puts "---------------------------------\n"
    end

    def self.next
      find('#lecture_complete_button').click
    end
  end
end
