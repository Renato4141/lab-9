class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      if current_user.admin? || current_user.vet?
        redirect_to owners_path
      elsif current_user.owner? && current_user.owner.present?
        redirect_to owner_path(current_user.owner)
      else
        # owner sin registro de Owner aún — mostrar la vista home
      end
    end
  end
end