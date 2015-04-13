class CommentsController < ApplicationController
	
def index

end

def create
	@user = current_user
	@post = Post.find(params[:post_id])
	@comment = Comment.create!(comment_params)
	@rel1 =  UserComment.create!(from_node: @user, to_node: @comment)
	@rel2 =  PostComment.create!(from_node: @post, to_node: @comment)
	
	@results = Neo4j::Session.query.match("(post { uuid: '#{@post.uuid}' })-[:postComment*..]->(comment),(comment)<-[:userComment]-(user)").order("comment.created_at DESC").limit(80).pluck(:comment, :user)

	respond_to do |format|
        format.js {  }
        format.json { }
    end
end

def destroy
	@interest = Interest.find(params[:id])
	rel = current_user.rels(type: :userInterests, between: @interest)
	rel[0].destroy
	@interest.destroy
	@interests = current_user.userInterests
	@interests_count = @interests.count
end

def update
	@interest = Interest.find(params[:id])
	@interest.update!(interest_params)
	@interests = current_user.userInterests
	@interests_count = @interests.count
end

private

def comment_params
   params.require(:comment).permit(:content)
end

end
