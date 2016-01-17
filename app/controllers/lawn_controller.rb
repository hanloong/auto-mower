class LawnController < ApplicationController
  before_action :set_lawn, except: :create

  def create
    lawn = Lawn.create lawn_params
    if lawn.persisted?
      render json: lawn and return
    end
    render json: { errors: lawn.errors }
  end

  def show
    render json: [] and return unless @lawn

    render json: @lawn
  end

  def update
    render json: [] and return unless @lawn

    if @lawn.update lawn_params
      render json: @lawn and return
    end
    render json: { errors: lawn.errors }
  end

  def destroy
    render json: [] and return unless @lawn

    @lawn.destroy
    render json: { status: 'ok' }
  end

  def execute
    if @lawn.mow!
      render json: @lawn
    else
      render json: { errors: @lawn.errors }
    end
  end

  private

  def lawn_params
    params.permit(:width, :height)
  end

  def set_lawn
    @lawn = Lawn.find_by id: params[:id]
  end
end
