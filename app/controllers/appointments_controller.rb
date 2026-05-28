class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.includes(:pet, :vet)

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
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to @appointment, notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: "Appointment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment was successfully deleted."
  end

  private

  def set_appointment
    @appointment = Appointment.includes(treatments: :rich_text_clinical_notes).find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:pet_id, :vet_id, :date, :reason, :status)
  end
end