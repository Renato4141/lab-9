class TreatmentsController < ApplicationController
  after_action :verify_authorized

  before_action :set_appointment
  before_action :set_treatment, only: [:edit, :update, :destroy]

  def new
    @treatment = @appointment.treatments.build
    authorize @treatment
  end

  def create
    @treatment = @appointment.treatments.build
    authorize @treatment
    if @treatment.update(treatment_params)
      redirect_to @appointment, notice: "Treatment created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @treatment
  end

  def update
    authorize @treatment
    if @treatment.update(treatment_params)
      redirect_to @appointment, notice: "Treatment updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @treatment
    @treatment.destroy
    redirect_to @appointment, notice: "Treatment deleted successfully"
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def set_treatment
    @treatment = @appointment.treatments.find(params[:id])
  end

  def treatment_params
    params.require(:treatment).permit(permitted_attributes(@treatment))
  end
end