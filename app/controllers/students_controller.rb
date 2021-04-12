class StudentsController < ApplicationController
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

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
