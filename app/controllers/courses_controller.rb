class CoursesController < ApplicationController
  before_action :set_instance_vars, only: %i[ new create edit update ]
  before_action :set_course, only: %i[ show edit update ]
  before_action :set_subjects, only: %i[ edit update ]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
    @subjects = Subject.all
    @course.course_subjects.build
  end

  def show
  end

  def edit    
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

  def update
    params[:course][:course_subjects_attributes].each do |attr_set|
      if attr_set.last[:subject_id].blank?
        attr_set.last[:_destroy] = '1'
      end
    end
    if @course.update(course_params)
      redirect_to @course, notice: 'Curso actualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar curso.'
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit(:description, :acronymn, :kind, course_subjects_attributes: [:id, :subject_id, :school_grade_id, :_destroy])
  end

  def set_instance_vars
    @school_grades = SchoolGrade.all
    @course_kinds = Course.kinds.values
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def set_subjects
    @subjects = {
      in_course: Subject.in_course(@course),
      not_in_course: Subject.not_in_course(@course)
    }
  end
end
