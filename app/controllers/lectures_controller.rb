class LecturesController < ApplicationController
  def index
    @lectures = policy_scope(Lecture).where(batch_id: params[:batch_id])
    @batch = Batch.find(params[:batch_id])
    @school_quarters = SchoolQuarter.all
  end
end
