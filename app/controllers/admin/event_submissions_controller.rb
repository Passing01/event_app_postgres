class Admin::EventSubmissionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_event, only: [:show, :edit, :update]

  def index
    @events = Event.where(reviewed: false)
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      @event.reviewed = true
      @event.save
      UserMailer.event_validation_email(@event).deliver_now
      redirect_to [:admin, @event], notice: 'Événement mis à jour avec succès.'
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:validated)
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Vous n'avez pas les droits d'accès."
    end
  end
end
