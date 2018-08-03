# frozen_string_literal: true
require_relative 'base_page'

module PageObjects
  class Lecture < BasePage
    def self.interact
      raise 'Lecture::interact() is not defined'
    end

    def self.next
      raise 'Lecture::next() is not defined'
    end
  end
end
