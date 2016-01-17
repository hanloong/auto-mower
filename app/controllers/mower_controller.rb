class MowerController < ApplicationController
  before_action :set_lawn
  before_action :set_mower, except: :create

  def show
    render json: [] and return if @lawn.nil? || @mower.nil?
    render json: @mower
  end

  def create
    mower = Mower.create mower_params.merge(lawn: @lawn)
    if mower.persisted?
      render json: mower and return
    end
    render json: { errors: mower.errors }
  end

  def update
    render json: [] and return if @lawn.nil? || @mower.nil?

    if @mower.update mower_params
      render json: @mower and return
    end
    render json: { errors: @mower.errors }
  end

  def destroy
    render json: [] and return if @lawn.nil? || @mower.nil?

    @mower.destroy
    render json: { status: 'ok' }
  end

  private

  def mower_params
    params.permit(:x, :y, :heading, :commands)
  end

  def set_mower
    @mower = Mower.find_by id: params[:id]
  end

  def set_lawn
    @lawn = Lawn.find_by id: params[:lawn_id]
  end
end
