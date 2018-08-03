# frozen_string_literal: true
require 'spec_helper'

require_relative '../../models/user'

include Models

COURSES = ['take home test'].freeze

describe 'testable ete test' do
  before :all do
    id    = Time.now.hash.abs.to_s
    @user = User.new({
                         name:  "CoderJep #{id}",
                         email: "coderjep+testable_#{id}@gmail.com",
                     })
  end

  it 'signup user' do
    # Home.visit
    visit 'http://takehome.zeachable.com'

    # Home.enroll
    click_link 'Enroll Now'

    # SiteEnrollment.signup#(@user)
    puts '---------------------------------'
    puts 'User:'
    puts @user
    puts "---------------------------------\n"

    fill_in 'Full Name', { with: @user.name }
    fill_in 'Email Address', { with: @user.email }
    fill_in 'Password', { with: @user.password }
    fill_in 'Confirm Password', { with: @user.password }
    find('#user_unsubscribe_from_marketing_emails').click
    find('#user_agreed_to_terms').click
    click_button 'Sign Up'


    COURSES.each do |course_name|
      # Courses.view_course(course_name)
      unless find('.course-listing-title') { |c| c.text == course_name }
        fill_in 'search-courses', { with: course_name }
        click_button 'search-course-button'
      end

      expect(find('.course-listing-title')).to have_content(course_name)
      find('.course-listing-title') { |c| c.text == course_name }.click

      # CourseOverview.enroll
      enrollment_button = find('#enroll-button-top')
      expect(enrollment_button.text.downcase).to include('free')
      enrollment_button.click

      # verify confirmation
      expect(page).to have_content('Your order ID')
      order_id           = find('p', { text: 'Your order ID' }).text.split(' ').last
      confirmation_email = find('p', { text: 'email confirmation at' }).text.split(' ').last
      expect(order_id).to match(/^[0-9]*$/)
      expect(confirmation_email).to include(@user.email)

      # EnrollmentConfirmation.continue
      click_link 'Continue to Course'

      # verify CourseCurriculum is at 0%, etc
      expect(page).to have_content 'Class Curriculum'

      percent_complete = find('.percentage').text
      expect(percent_complete).to eq '0%'

      # store lectures
      lectures = all('.lecture-name').map(&:text)

      click_link 'Start next lecture'
      expect(page).to have_no_content('Class Curriculum')

      lectures_completed = 0
      while lectures_completed < lectures.count
        expect(find('.next-lecture')).to have_content(lectures[lectures_completed])

        expected_percent_complete = "#{100 * lectures_completed / lectures.count}%"
        expect(find('.percentage')).to have_content(expected_percent_complete)
        percent_complete = find('.percentage').text
        expect(percent_complete).to eq expected_percent_complete

        text      = all('.lecture-text-container').map(&:text)
        pdfs      = all('.attachment-pdf-embed')
        videos    = all('.wistia_embed')
        downloads = all('.download')

        puts '---------------------------------'
        puts "Lecture #{lectures_completed + 1} `#{lectures[lectures_completed]}` contains:"
        puts "The following text:\n #{text.join('\n')}" unless text.count == 0
        puts "The following pdfs:\n #{pdfs.map(&:text).join('\n')}" unless pdfs.count == 0
        puts "The following downloads:\n #{downloads.map(&:text).join('\n')}" unless downloads.count == 0
        puts "#{videos.count} video(s)" unless videos.count == 0
        puts "---------------------------------\n"

        find('#lecture_complete_button').click

        lectures_completed += 1
      end

      expect(page).to have_content('Class Curriculum')
      expect(lectures_completed).to eq lectures.count

      percent_complete = find('.percentage').text
      # Bug here, progress jumps down to 0%.
      # Depending on progress and when you return to the curriculum page, this value could be different, but never 100%
      # Does update if you click on "instructor", but will revert back once you click on course curriculum again.
      expect(percent_complete).to eq '100%'

      find('.nav-icon-back').click
    end
  end
end
