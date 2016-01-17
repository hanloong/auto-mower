class LawnController < ApplicationController
  before_action :set_lawn, except: :create

  def show
    render json: @lawn
  end

  def create
    lawn = Lawn.create lawn_params
    if lawn.persisted?
      render json: lawn and return
    end
    render json: { errors: lawn.errors }
  end

  def update
    if @lawn.update lawn_params
      render json: @lawn and return
    end
    render json: { errors: lawn.errors }
  end

  def destroy
    @lawn.destroy
    render json: { status: 'ok' }
  end

  def execute
    render :nothing
  end

  private

  def lawn_params
    params.permit(:width, :height)
  end

  def set_lawn
    @lawn = Lawn.find params[:id]
  end
end
