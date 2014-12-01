class Like_testimonial 
	include Neo4j::ActiveRel
	property :created_at  # will automatically be set when model changes
	property :updated_at  # will automatically be set when model changes


  from_class User
  to_class   Testimonial
  type 'likes_testimonial'

end
