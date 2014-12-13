class LocationsController < ApplicationController

def create
  if params[:my_location][:place_id].nil?
      return
    end
      @location = Location.find_by(place_id: params[:place_id])
    if @location.nil?
     @location = Location.create(location_params)
    end
     @user = User.find(params[:user_id])
     @myLocation = MyLocation.create(my_location_params)
     @place_rel =  Place.create(from_node: @user, to_node: @myLocation)
	   @loc_rel =  LocationMaster.create(from_node: @myLocation, to_node: @location)
=begin
	@locations = @user.places
=end

end

def destroy
    @location = MyLocation.find(params[:id])
      current_user.rels(type: :places, between: @location)[0].destroy
      @location.rels(dir: :outgoing, type: "location_details")[0].destroy
      @location.destroy
end

def update
	@location = MyLocation.find(params[:id])
	@location.update!(my_location_params)
end

private

def my_location_params
   params.require(:my_location).permit(:address, :name, :place_id, :id_loc, :latitude, :longitude, :place_type, :details, :current_place)
end

def location_params
   params.require(:my_location).permit(:address, :name, :place_id, :id_loc, :latitude, :longitude)
end

end
