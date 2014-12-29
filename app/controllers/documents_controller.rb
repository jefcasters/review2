class DocumentsController < ApplicationController
  before_action :authenticate_user!, :set_cache_headers
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :posso, only: [:show]
  before_action :set_user, only: [:index, :create, :destroy, :show, :new]
  respond_to :html


  def find_my_root
    if(current_user.admin)
      redirect_to users_path(@user)
    else
      @user = current_user
      redirect_to user_documents_path(@user)
    end
  end

  def index
    # Shows all documents, the ones that were last updated first

    @documents = @user.documents.order('updated_at DESC')
    respond_with(@user,@documents)
  end

  def show
    @document = Document.find(params[:id])
    @images = @document.images.order('created_at DESC')
    respond_with(@user,@document)
  end

  def new
    @document = Document.new
    respond_with(@document)
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.user_id = params[:user_id]
    @document.created_by = current_user.name
    @document.save
    # flash[:notice] = "Document Succesfuly created. Please upload a first version of this document."
    respond_with(@user,@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @document.destroy
    redirect_to user_documents_path(@user)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:title, :image)
    end

    def posso
      @document = Document.find(params[:id])
      redirect_to root_path unless @document.user_id == current_user.id || current_user.admin
    end

end
