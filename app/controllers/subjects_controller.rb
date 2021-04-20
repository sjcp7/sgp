class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def create
    @subject = Subject.create(subject_params)
    if @subject.save
      redirect_to subjects_path, notice: 'Disciplina criada com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar disciplina.'
      render :new
    end
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      redirect_to subjects_path, notice: 'Disciplina actualizada com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar disciplina.'
      render :edit
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:description, :acronymn)
  end
end
