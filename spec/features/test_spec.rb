# frozen_string_literal: true
# require 'spec_helper'

require_relative '../../models/user'
require_relative '../../page_objects/course_overview'
require_relative '../../page_objects/course_curriculum'
require_relative '../../page_objects/courses'
require_relative '../../page_objects/enrollment_confirmation'
require_relative '../../page_objects/home'
require_relative '../../page_objects/lecture'
require_relative '../../page_objects/site_enrollment'

include Models
include PageObjects

describe 'testable ete test' do
  before :all do
    id = Time.now.hash.abs.to_s
    @user = User.new({
                         name:  "CoderJep #{id}",
                         email: "coderjep+testable_#{id}@gmail.com",
                     })
  end

  it 'signup user' do
    # Home.enroll
    # SiteEnrollment.signup#(@user)
    # expect logged in on Courses page (maybe check any page)
    raise '`signup user case` not complete'
  end

  it 'enrolls in course' do
    # Courses.view_course(course_name)
    # CourseOverview.enroll
    # verify confirmation
    raise '`enrolls in course` not complete'
  end

  it 'Loads unfinished course curriculum' do
    # EnrollmentConfirmation.continue
    # verify CourseCurriculum is at 0%, etc
    # store lectures
    raise '`Loads unfinished course curriculum` case not complete'
  end

  it 'completes lectures' do
    # loop through lectures
    # Lecture.interact
    # Lecture.next
    # Verify CourseCurriculum is at 100%, etc
    raise '`completes lectures case` not complete'
  end

  after :all do
    Home.quit
  end
end
