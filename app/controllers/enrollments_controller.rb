class EnrollmentsController < ApplicationController
  def index
    @enrollments = Batch.find(params[:batch_id]).enrollments
  end

  def create
    @enrollment = Enrollment.create(enrollement_params)
    respond_to do |format|
      if @enrollment.save
        format.js
      end
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    @enrollment.destroy
  end

  private

  def enrollement_params
    params.require(:enrollment).permit(:student_id, :batch_id)
  end
end
