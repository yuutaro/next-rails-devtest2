class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { status: 'ok' }, status: :ok
  end
end
