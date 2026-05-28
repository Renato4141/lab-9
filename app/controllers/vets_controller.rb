class VetsController < ApplicationController
  before_action :set_vet, only: [:show, :edit, :update, :destroy]

  def index
    @vets = policy_scope(Vet)
    @vets = @vets.by_specialization(params[:specialization]) if params[:specialization].present?
  end

  def show
    authorize @vet
  end

  def new
    @vet = Vet.new
    authorize @vet
  end

  def create
    @vet = Vet.new
    authorize @vet
    if @vet.update(vet_params)
      redirect_to @vet, notice: "Vet created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @vet
  end

  def update
    authorize @vet
    if @vet.update(vet_params)
      redirect_to @vet, notice: "Vet updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @vet
    @vet.destroy
    redirect_to vets_path, notice: "Vet deleted successfully"
  end

  private

  def set_vet
    @vet = Vet.find(params[:id])
  end

  def vet_params
    params.require(:vet).permit(permitted_attributes(@vet))
  end
end