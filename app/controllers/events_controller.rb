#class EventsController < ApplicationController
#  before_action :authenticate_user!, except: [:index, :show]
  
#  def index
#    @events = Event.all
#  end

#  def new
#    @event = Event.new
#  end

#  def create
#    @event = current_user.events.build(event_params)
#    if @event.save
#      redirect_to @event
#    else
#      render :new
#    end
#  end

#  def show
#    @event = Event.find(params[:id])
#  end

#  private

#  def event_params
#    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
#  end
#end
class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.where(validated: true)
  end


  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.validated = false
    @event.reviewed = false
    if @event.save
      redirect_to @event, notice: 'Événement créé avec succès.'
    else
      render :new
    end
  end


  def show
    @event = Event.find(params[:id])
    if @event.validated
      render :show
    else
      redirect_to events_path, alert: 'Cet événement est en cours de validation.'
    end
  end


  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
