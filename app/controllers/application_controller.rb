class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @days = [ 'Thursday', 'Friday', 'Saturday' ]
    @times = (0..11).step(1).map{ |i| "#{(11+i)%12+1}am" }
    @times = @times + @times.map{ |t| t.sub('a','p') }
    @venues = Venue.all
  end
end
