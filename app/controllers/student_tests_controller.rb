class StudentTestsController < ApplicationController
  def create
  end

  def update
    @student_test = StudentTests.create(student_tests_params)
    batch = @student_test.test.lecture.batch
    if @student_test.save
      flash[:notice] = 'Notas actualizadas com sucesso.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    else
      flash[:notice] = 'Não foi possível actualizar notas.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    end
  end

  private

  def student_tests_params
    params.require(:student_tests).permit(:max_score, student_test: [:score, :student, :test])
  end
end
