class LecturesController < ApplicationController
  def index
    @batch = Batch.find(params[:batch_id])
    @lectures = policy_scope(Lecture).where(batch: @batch)
    @school_quarters = SchoolQuarter.all
    @lectures_with_tests = @lectures.map do |lecture|
      @school_quarters.map do |sq|
        { lecture: lecture, sq: sq, tests: lecture.tests.find_by_school_quarter(sq) }
      end
    end.first
  end
end
