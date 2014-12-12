class LocationMaster 
	include Neo4j::ActiveRel
	property :created_at  # will automatically be set when model changes
	property :updated_at  # will automatically be set when model changes

  from_class MyLocation
  to_class   Location
  type 'location_details'

end
