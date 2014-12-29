class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :destroy]
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_document, only: [:show, :create, :destroy]
  respond_to :html

  def index
    @images = Image.all
    respond_with(@images)
  end

  def show
    @image = Image.find(params[:id])
    @comments = @image.comments
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def edit
  end

  def create
    if(current_user.admin)
      @user = User.find(@document.user_id)
    else
      @user = current_user
    end
    # @image = Image.new(image_params)
    # @image.user_id = @user.id
    # @image.document_name = Document.find(params[:document_id]).title
    # @image.save


    @image = @document.images.create(image_params)
    @image.user_id = @user.id
    @image.document_name = Document.find(params[:document_id]).title
    @image.save

    redirect_to user_document_path(@user, @document)
  end

  def update
    @image.update(image_params)
    respond_with(@image)
  end

  def destroy
    @image = @document.images.find(params[:id])
    @image.destroy
    redirect_to user_document_path(@user, @document)
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:foto)
    end

    def document_params
      params.require(:image).permit(:image)
    end
end
