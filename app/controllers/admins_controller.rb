class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
    @admin.build_user
  end
  
  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.create(admin_params)
    if @admin.save
      redirect_to admins_path, notice: 'Administrador criado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar administrador.'
      render :new
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if @teacher.update(teacher_params)
      redirect_to admins_path, notice: 'Administrador actualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar administrador.' 
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, user_attributes: [:id, :email, :password])
  end
end
