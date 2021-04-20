class StudentsController < ApplicationController
  def index
    @students = Student.all
    authorize @students
  end

  def edit
    @student = Student.find(params[:id])
    authorize @student
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    if @student.save
      redirect_to root_path, notice: 'Estudante criado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar estudante.'
      render :new
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to students_path, notice: 'Estudante actualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar estudante.'
      render :edit
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
