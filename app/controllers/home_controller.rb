class HomeController < ApplicationController
  def index
    redirect_to batches_path
  end
end
