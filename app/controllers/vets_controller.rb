class VetsController < ApplicationController
  before_action :set_vet, only: [:show, :edit, :update, :destroy]

  def index
    @vets = params[:specialization] ? Vet.by_specialization(params[:specialization]) : Vet.all
  end

  def show
  end

  def new
    @vet = Vet.new
  end

  def create
    @vet = Vet.new(vet_params)
    if @vet.save
      redirect_to @vet, notice: "Vet created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vet.update(vet_params)
      redirect_to @vet, notice: "Vet updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vet.destroy
    redirect_to vets_path, notice: "Vet deleted successfully"
  end

  private

  def set_vet
    @vet = Vet.find(params[:id])
  end

  def vet_params
    params.require(:vet).permit(:first_name, :last_name, :email, :phone, :specialization)
  end
end