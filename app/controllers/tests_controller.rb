class TestsController < ApplicationController
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
end
