class TestsController < ApplicationController
  def index
    @lecture = policy_scope(Lecture).find(params[:lecture_id])
    @students = @lecture.students
    @school_quarter = SchoolQuarter.find(params[:school_quarter_id])
    if params[:kind] == 'AC'
      @num_of_ac = get_num_of_ac_by_school_grade(@school_quarter)
      render template: 'tests/index_ac'
    elsif params[:kind] == 'Trimestral'
      render template: 'tests/index_trimestral'
    end
  end

  def create
    students = Lecture.find(params[:lecture_id]).students
    test_list = students.map do |student|
      { 
        student: student, kind: params[:kind], 
        score: params[:score], max_score: params[:max_score], school_quarter_id: params[:school_quarter_id],
        lecture_id: params[:lecture_id]
      }
    end
    result = Test.create(test_list)
    if result.all?(&:persisted?)
      flash[:notice] = 'Avaliação contínua criada com sucesso.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    else
      flash.now[:alert] = 'Não foi possível criar avaliação contínua.'
      batch = Lecture.find(params[:lecture_id]).batch
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    end
  end

  private
  
  def get_num_of_ac_by_school_grade(school_quarter)
    @students.first.tests.where(school_quarter: school_quarter).AC.count
  end
end
