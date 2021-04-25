class SchoolQuartersController < ApplicationController
  def index
    @school_quarters = SchoolQuarter.all
  end

  def update
    @school_quarter = SchoolQuarter.find(params[:id])
    if @school_quarter.update(school_quarter_params)
      redirect_to school_quarters_path, notice: 'Trimestre actualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar trimestre.'
      render :index
    end
  end

  private

  def school_quarter_params
    params.require(:school_quarter).permit(:id, :year, :current)
  end
end
