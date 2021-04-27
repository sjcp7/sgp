class TestsController < ApplicationController
  def index
    @lecture = policy_scope(Lecture).find(params[:lecture_id])
    @school_quarter = SchoolQuarter.find(params[:school_quarter_id])
    @students_with_tests = @lecture.students.map do |student|
      { student: student, tests: student.tests.find_by_lecture(@lecture).find_by_school_quarter(@school_quarter) }
    end
    @num_of_ac = ac_tests_count(@school_quarter)
    if params[:kind] == 'AC'
      render template: 'tests/index_ac'
    elsif params[:kind] == 'Trimestral'
      render template: 'tests/index_trimestral'
    end
  end

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
    params.require(:test).permit(:lecture_id, :school_quarter_id, :kind, :max_score, student_tests_attributes: [:id, :score, :student_id])
  end

  def ac_tests_count(school_quarter)
    @lecture.tests.find_by_school_quarter(@school_quarter).AC.size
  end
end
