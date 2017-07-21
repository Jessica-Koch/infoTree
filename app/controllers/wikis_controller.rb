class WikisController < ApplicationController
  before_action :authenticate_user!
  before_action :collaborators_only, only: :show
  # before_action :contains_collaborator?, only: [:create, :update]


  def index
    @wikis = policy_scope(Wiki)
    @wikis = Wiki.page(params[:page]).per(10)
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.create(wiki_params)

    if @wiki.save
      @wiki.collaborators.create(user: current_user, role: 0)

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
    @wiki.collaborators.create(user: current_user, role: 1)

    if @wiki.save
      contains_collaborator?
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
  def contains_collaborator?
    wiki = Wiki.find(params[:id])
    if !wiki.users.include?(current_user)
      wiki.collaborators.create(user: current_user)
    end
  end

  def collaborators_only
    wiki = Wiki.find(params[:id])
    unless wiki.users.include?(current_user) || current_user.admin? || !wiki.private
      redirect_to wikis_path, alert: 'You do not have access to this wiki'
    end
  end



  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
