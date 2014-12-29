class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_document, only: [:create, :update, :destroy]


  respond_to :html
  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@document)
  end

  def edit

  end

  def create

    @comment = Comment.new(comment_params)
    @comment.image_id = params[:image_id]
    @comment.document_id = params[:document_id]
    @comment.user_id = params[:user_id]
    @comment.comment_by = current_user.id
    @comment.comment_name = current_user.name
    @comment.document_name = Document.find(params[:document_id]).title
    @comment.save

    @image = Image.find(params[:image_id])


    # @document.updated_at = Time.now
    # @document.save

  end

  def update

    if(@document.user_id = @user.id)
      @comment = Comment.find(params[:id])
      @comment.update(:value=>params[:value])
    end

  end

  def destroy
    if(@document.user_id == @user.id)
      @image = Image.find(params[:image_id])
      @comment = @image.comments.find(params[:id])
      @comment.destroy
      respond_with(@user,@document,@image)
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:value, :reviewed)
    end
end
