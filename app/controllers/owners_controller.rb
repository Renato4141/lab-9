class OwnersController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  def index
    @owners = policy_scope(Owner)
  end

  def show
    authorize @owner
  end

  def new
    @owner = Owner.new
    authorize @owner
  end

  def create
    @owner = Owner.new
    authorize @owner
    if @owner.update(owner_params)
      redirect_to @owner, notice: "Owner created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @owner
  end

  def update
    authorize @owner
    if @owner.update(owner_params)
      redirect_to @owner, notice: "Owner updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @owner
    @owner.destroy
    redirect_to owners_path, notice: "Owner deleted successfully"
  end

  private

  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owner_params
    params.require(:owner).permit(permitted_attributes(@owner))
  end
end