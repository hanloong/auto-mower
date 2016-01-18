class MowerController < ApplicationController
  before_action :set_lawn
  before_action :check_lawn
  before_action :set_mower, except: :create
  before_action :check_mower, except: :create

  def show
    render json: @mower
  end

  def create
    mower = Mower.create mower_params.merge(lawn: @lawn)
    if mower.persisted?
      render json: mower and return
    end
    render json: { errors: mower.errors }, status: :bad_request
  end

  def update
    if @mower.update mower_params
      render json: @mower and return
    end
    render json: { errors: @mower.errors }, status: :bad_request
  end

  def destroy
    @mower.destroy
    render json: { status: 'ok' }
  end

  private

  def mower_params
    params.permit(:x, :y, :heading, :commands)
  end

  def set_lawn
    @lawn = Lawn.find_by id: params[:lawn_id]
  end

  def set_mower
    @mower = @lawn.mowers.find_by id: params[:id]
  end

  def check_lawn
    unless @lawn
      render json: {message: 'lawn not found'}, status: :not_found and return
    end
  end

  def check_mower
    unless @mower
      render json: {message: 'mower not found'}, status: :not_found and return
    end
  end
end
