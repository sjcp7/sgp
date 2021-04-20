class RequestsController < ApplicationController
  def index
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      batch = @request.test.batch
      flash[:notice] = 'Pedido enviado com sucesso.'
      redirect_back fallback_location: proc { batch_lectures_path(batch) }
    else
      flash[:notice] = 'Não foi possível enviar pedido.'
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:teacher_id, :test_id, :message)
  end
end