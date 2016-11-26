class CommentsController < ApplicationController
   
   def new
      @comment = Comment.new
   end
    
   def create
       @comment = Comment.new(comment_params)
       
       if @comment.save
        redirect_to :back, notice: 'Your comment was successfully posted!'
      else
        redirect_to :back, notice: "Your comment wasn't posted!"
      end
   end

   private

   def comment_params
        params.require(:comment).permit(:user_id, :home_id)
   end

    
end
