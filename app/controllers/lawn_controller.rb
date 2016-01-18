class LawnController < ApplicationController
  before_action :set_lawn, except: :create
  before_action :check_lawn, except: :create

  def create
    lawn = Lawn.create lawn_params
    if lawn.persisted?
      render json: lawn and return
    end
    render json: { errors: lawn.errors }, status: :bad_request
  end

  def show
    render json: @lawn
  end

  def update
    if @lawn.update lawn_params
      render json: @lawn and return
    end
    render json: { errors: lawn.errors }, status: :bad_request
  end

  def destroy
    @lawn.destroy
    render json: { status: 'ok' }
  end

  def execute
    if @lawn.mow!
      render json: @lawn
    else
      render json: { errors: @lawn.errors }, status: :bad_request
    end
  end

  private

  def lawn_params
    params.permit(:width, :height)
  end

  def set_lawn
    @lawn = Lawn.find_by id: params[:id]
  end

  def check_lawn
    unless @lawn
      render json: {message: 'lawn not found'}, status: :not_found and return
    end
  end
end
