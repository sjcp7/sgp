class SchoolYearsController < ApplicationController
  def index
    @school_years = SchoolYear.all
  end

  def new
    @school_year = SchoolYear.new
  end

  def create
    @school_year = SchoolYear.create(school_year_params)
    if @school_year.save
      redirect_to school_years_path, notice: 'Ano lectivo criado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível criar ano lectivo.'
      render :new
    end
  end

  def update
    @school_year = SchoolYear.find(params[:id])
    if @school_year.update(school_year_params)
      redirect_to school_years_path, notice: 'Ano lectivo actualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizado ano lectivo.'
      render :edit
    end
  end

  private

  def school_year_params
    params.require(:school_year).permit(:id, :year, :current)
  end
end
