class TripsController < ApplicationController
  def index
    
  end
  def show
    
  end

  def create
    if params.has_key?(:user_id) && params.has_key?(:depart) && params.has_key?(:arrivee) && params.has_key?(:nb_passager)
      trip = Trip.new
      trip.user_id = params[:user_id]
      trip.aerodrome_dep_id = params[:depart]
      trip.aerodrome_arr_id = params[:arrivee]
      trip.nb_passager = params[:nb_passager]
      trip.save
    else
        render json: {error: user.errors}, status: :bad_request
    end
  end


end