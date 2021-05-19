class LecturesController < ApplicationController
  def index
    @batch = Batch.find(params[:batch_id])
    @lectures = policy_scope(Lecture).where(batch: @batch)
    @school_quarters = SchoolQuarter.all
  end

  def create
    @lecture = Lecture.create(lecture_params)
  end

  def update
    @lecture = Lecture.find(params[:id])
    @lecture.update(lecture_params)
  end

  private

  def lecture_params
    params.require(:lecture).permit(:id, :batch, :teacher_id, :course_subject)
  end
end
