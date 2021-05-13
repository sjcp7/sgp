class ScoresheetsController < ApplicationController
  def show
    if params[:kind] == 'AC'
      set_vars_for_ac_and_trimestral
      set_num_of_ac_tests
      render 'ac'
    elsif params[:kind] == 'Trimestral'
      set_vars_for_ac_and_trimestral
      render 'trimestral'
    else
      set_vars_for_global
      render 'global'
    end
  end

  private 

  def set_vars_for_ac_and_trimestral
    @lecture = policy_scope(Lecture).find(params[:lecture_id])
    @school_quarter = SchoolQuarter.find(params[:school_quarter_id])
    @students_with_tests = @lecture.students.map do |student|
      { student: student, tests: student.tests.find_by_lecture(@lecture).find_by_school_quarter(@school_quarter) }
    end
    
  end

  def set_num_of_ac_tests
    @num_of_ac = Test.ac_tests_count_by_lecture_and_school_quarter(@lecture, @school_quarter)
  end

  def set_vars_for_global
    @batch = Batch.includes(:tests, :students, :lectures).find(params[:batch_id])
    @lectures = @batch.lectures
    @students_with_tests = @batch.students.map do |student|
      { student: student, tests: student.tests }
    end
  end
end
