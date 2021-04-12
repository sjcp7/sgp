class TeachersController < ApplicationController
  def new
    @teacher = Teacher.new
    @teacher.build_user
  end

  def create
    @teacher = Teacher.create(teacher_params)
    if @teacher.save
      redirect_to root_path, notice: 'Professor criado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar professor.'
      render :new
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, user_attributes: [:id, :email, :password])
  end
end
