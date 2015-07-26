class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @days = [ 'Thursday', 'Friday', 'Saturday' ]
    @times = [ '12am', '6am', '12pm', '6pm' ]
    @venues = Venue.all
  end
end
