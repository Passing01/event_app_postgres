class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:index]

  def new
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new
  end

  def create
  @event = Event.find(params[:event_id])
  @attendance = @event.attendances.build(attendance_params)
  @attendance.user = current_user

  if @event.is_free?
    @attendance.save
    redirect_to @event, notice: 'Vous avez rejoint l\'événement avec succès.'
  else
    begin
      # Charger l'utilisateur via Stripe
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: params[:attendance][:stripe_id]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @event.price_cents,
        description: "Paiement pour l'événement #{@event.name}",
        currency: 'eur'
      )

      @attendance.stripe_id = customer.id
      @attendance.save

      redirect_to @event, notice: 'Vous avez rejoint l\'événement avec succès.'
      rescue Stripe::CardError => e
        # Gérer les erreurs de carte
        flash[:alert] = e.message
        render :new
      end
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:stripe_token)
  end

  def index
    @event = Event.find(params[:event_id])
    @attendances = @event.attendances
  end

  private

  def require_admin
    @event = Event.find(params[:event_id])
    redirect_to root_path, alert: 'Vous n\'avez pas les droits pour accéder à cette page.' unless @event.admin == current_user
  end
end
