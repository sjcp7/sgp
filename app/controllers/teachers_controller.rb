class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
    @teacher.build_user
  end

  def show
    @teacher = Teacher.find(params[:id])
    @lectures = Lecture.find_by_teacher(@teacher)
  end
  
  def edit
    @teacher = Teacher.find(params[:id])
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

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      redirect_to teacher_path(@teacher), notice: 'Professor actualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar professor.' 
      render :edit
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, user_attributes: [:id, :email, :password])
  end
end
