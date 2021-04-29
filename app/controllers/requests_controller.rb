class RequestsController < ApplicationController
  def index
    @requests = policy_scope(Request)
    authorize @requests
  end

  def show
    @request = Request.find(params[:id])
    authorize @request
  end

  def new
    @request = Request.new
    @test_id = params[:test_id]
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    if @request.save
      batch = @request.test.batch
      flash[:notice] = 'Pedido enviado com sucesso.'
      redirect_to batch_lectures_path(batch)
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
