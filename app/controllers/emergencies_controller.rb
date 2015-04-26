class EmergenciesController < ApplicationController
  def create
    begin
      @emergency = Emergency.create(emergency_params)
    rescue Exception => e
      render json: {message: e.message}, status: 422 and return
    end
    if @emergency.save
      render json: {message: nil, emergency: @emergency}, status: 201
    else
      render json: {message: @emergency.errors}, status: 422
    end
  end

  private
  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity,
      :police_severity, :medical_severity)
  end
end
