class TestsController < ApplicationController
  def index
    @lecture = policy_scope(Lecture).find(params[:lecture_id])
    @school_quarter = SchoolQuarter.find(params[:school_quarter_id])
    @students_with_tests = @lecture.students.map do |student|
      { student: student, tests: student.tests.find_by_school_quarter(@school_quarter) }
    end
    @num_of_ac = ac_tests_count(@school_quarter)
    if params[:kind] == 'AC'
      render template: 'tests/index_ac'
    elsif params[:kind] == 'Trimestral'
      render template: 'tests/index_trimestral'
    end
  end

  def create
    students = Lecture.find(params[:lecture_id]).students
    test = Test.create(test_params)
    student_tests_list = students.map do |student|
      student_test_params(student, test)
    end
    
    result = StudentTest.create(student_tests_list)
    if result.all?(&:persisted?) && test.save? 
      flash[:notice] = 'Avaliação contínua criada com sucesso.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    else
      flash.now[:alert] = 'Não foi possível criar avaliação contínua.'
      batch = Lecture.find(params[:lecture_id]).batch
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    end
  end

  private

  def test_params
    params.require(:test).permit(:lecture_id, :school_quarter_id, :kind)
  end

  def student_test_params(student, test)
    other_params = { student: student, test: test }
    params.require(:student_test).merge(other_params).permit(:test, :student, :score)
  end

  def ac_tests_count(school_quarter)
    @lecture.students.first.tests.AC.where(school_quarter: @school_quarter).size
  end
end
