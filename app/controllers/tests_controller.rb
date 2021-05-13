class TestsController < ApplicationController
  def edit
    @test = Test.find(params[:id])
    authorize @test
    @student_tests = @test.student_tests
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      flash[:notice] = 'Avaliação contínua criada com sucesso.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    else
      flash[:alert] = 'Não foi possível criar avaliação contínua.'
      batch = Lecture.find(params[:lecture_id]).batch
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    end
  end

  def update
    @test = Test.find(params[:id])
    @test.update(test_params)
    batch = @test.lecture.batch
    if @test.save
      redirect_to batch_lectures_path(batch), notice: 'Notas actualizadas com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível actualizar notas.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    end
  end

  private

  def test_params
    params.require(:test).permit(:id, :lecture_id, :school_quarter_id, :kind, :max_score, :locked, student_tests_attributes: [:id, :score, :student_id])
  end
end
