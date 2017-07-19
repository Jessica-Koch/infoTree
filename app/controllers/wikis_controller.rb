class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
    @wikis = Wiki.page(params[:page]).per(10)
  end

  def new
    @wiki = Wiki.new
  end

  def create
    # @user = User.find(params[:user_id])
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = 'Congrats you just added a new node.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error'
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Post was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
