class LecturesController < ApplicationController
  def index
    @batch = Batch.find(params[:batch_id])
    @lectures = policy_scope(Lecture).where(batch: @batch)
    @school_quarters = SchoolQuarter.all
  end
end
