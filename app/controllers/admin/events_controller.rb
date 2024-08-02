class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to [:admin, @event], notice: 'Événement mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: 'Événement supprimé avec succès.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :validated, :reviewed)
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Vous n'avez pas les droits d'accès."
    end
  end
end
