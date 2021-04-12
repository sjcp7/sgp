class SubjectsController < ApplicationController
  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.create(subject_params)
    if @subject.save
      redirect_to root_path, notice: 'Disciplina criada com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar disciplina.'
      render :new
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:description, :acronymn)
  end
end
