class BatchesController < ApplicationController
  before_action :set_instance_vars, only: %i[ new create ]
  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    if @batch.save
      redirect_to root_path, notice: 'Turma criada com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar turma.'
      render :new
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:course_id, :school_year_id, :school_grade_id)
  end

  def set_instance_vars
    @courses = Course.all.map { |c| [c.acronymn, c.id] }
    @school_year = SchoolYear.current
    @school_grades = SchoolGrade.all.map { |sg| [sg.grade, sg.id] }
  end
end