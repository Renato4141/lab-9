class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = policy_scope(Appointment.includes(:pet, :vet))

    @appointments =
      case params[:filter]
      when "upcoming"
        @appointments.upcoming
      when "past"
        @appointments.past
      else
        @appointments
      end
  end

  def show
    authorize @appointment
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new
    authorize @appointment
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @appointment
  end

  def update
    authorize @appointment
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: "Appointment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @appointment
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment was successfully deleted."
  end

  private

  def set_appointment
    @appointment = Appointment.includes(treatments: :rich_text_clinical_notes).find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(permitted_attributes(@appointment))
  end
end