# frozen_string_literal: true
require_relative '../../models/user'
require_relative '../../page_objects/course_overview'
require_relative '../../page_objects/course_curriculum'
require_relative '../../page_objects/courses'
require_relative '../../page_objects/enrollment_confirmation'
require_relative '../../page_objects/home'
require_relative '../../page_objects/lecture'
require_relative '../../page_objects/session'
require_relative '../../page_objects/site_enrollment'

include Models
include PageObjects

COURSES = ['take home test'].freeze

describe 'testable ete test' do
  before :all do
    id        = Time.now.hash.abs.to_s
    @user     = User.new({
                             name:  "CoderJep #{id}",
                             email: "coderjep+testable_#{id}@gmail.com",
                         })
    @lectures = []
  end

  it 'signup user' do
    Home.go
    Home.enroll

    puts '---------------------------------'
    puts 'User:'
    puts @user
    puts "---------------------------------\n"
    SiteEnrollment.sign_up(@user)
  end

  COURSES.each do |course_name|
    it "enrolls in course `#{course_name}`" do
      Courses.view_course(course_name)
      expect(CourseOverview.enrollment_cost).to include('free')

      CourseOverview.enroll
      expect(EnrollmentConfirmation.order_id).to match(/^[0-9]*$/)
      expect(EnrollmentConfirmation.confirmation_email).to include(@user.email)
    end

    it "Loads unfinished course curriculum for `#{course_name}`" do
      EnrollmentConfirmation.continue

      expect(CourseCurriculum.percent_complete).to eq '0%'
      @lectures = CourseCurriculum.lectures
    end

    it "completes lectures for course `#{course_name}`" do
      CourseCurriculum.start

      lectures_completed = 0
      while lectures_completed < @lectures.count
        expected_percent_complete = "#{100 * lectures_completed / @lectures.count}%"
        Lecture.wait_for_ready(@lectures[lectures_completed], expected_percent_complete) # TODO: Make this an instance and init a lecture name
        expect(Lecture.percent_complete).to eq expected_percent_complete

        # TODO: This could be better, using for debugging
        Lecture.print_content(lectures_completed + 1, @lectures[lectures_completed])
        Lecture.next

        lectures_completed += 1
      end

      expect(lectures_completed).to eq @lectures.count
    end

    it "course `#{course_name}` status is update on curriculum" do
      CourseCurriculum.wait_for_ready

      # Bug here, progress jumps down to 0%.
      # Depending on progress and when you return to the curriculum page, this value could be different, but never 100%
      # Does update if you click on "instructor", but will revert back once you click on course curriculum again.
      expect(CourseCurriculum.percent_complete).to eq '100%'

      CourseCurriculum.return_to_courses
    end

    after :each do
      Session.keep
    end
  end
end
