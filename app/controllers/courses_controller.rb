class CoursesController < ApplicationController
  before_action :set_instance_vars, only: %i[ new create ]
  def new
    @course = Course.new
    @course.course_subjects.build
  end

  def create 
    @course = Course.create(course_params)
    if @course.save
      redirect_to root_path, notice: 'Curso criado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar curso.'
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:description, :acronymn, :kind, course_subjects_attributes: [:id, :course_id, :subject_id, :school_grade_id])
  end

  def set_instance_vars
    @subjects = Subject.all
    @school_grades = SchoolGrade.all
    @course_kinds = Course.kinds.values
  end
end
