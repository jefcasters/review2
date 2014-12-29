require 'json'
class AnnotationsController < ApplicationController

  before_action :authenticate_user!, :set_user, :set_image
  before_action :set_document, only: [:create, :update, :destroy]

  def index
    @annotations = @image.comments
  end

  def show
    @annotation = Comment.find(params[:id])
  end

  def new

  end

  def edit
  end

  def create
    create_annotation_hash_from_json()
    @document = Document.find(params[:document_id])
    @comment=Comment.create(:value=>@annotation_hash['text'],:json=>@annotation_json, :image_id=>@image.id, :isAnnotation=>true, :comment_by => current_user.id, :comment_name => current_user.name, :user_id => @user.id, :document_id=>params[:document_id], :image_id=>params["image_id"], :document_name=>@document.title)

    render :json=> @comment.to_json
  end

  def update
    # @document = Document.find(params[:document_id])
    if(my_document?)
      create_annotation_hash_from_json()
      @comment = @image.comments.find(params[:id])
      @comment.update(:value=>@annotation_hash['text'])
    end
  end

  def destroy
    # @document = Document.find(params[:document_id])
    if(my_document?)
      @comment = @image.comments.find(params[:id])
      @deleted_comment_id = @comment.id
      @comment.destroy
    end
  end

  private
    def my_document?
      if(@document.user_id == @user.id)
        return true
      else
        return false
      end
    end

    def set_image
      @image = Image.find(params[:image_id])
    end

    def create_annotation_hash_from_json
      @annotation_json=params[:annotation]
      @annotation_hash=JSON.parse(@annotation_json)
    end
end
