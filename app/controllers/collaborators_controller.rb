class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @collaborators = @wiki.collaborators.all
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(collaborator_params)
    @collaborator.wiki_id = @wiki.id

    if @collaborator.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added."
    else
      flash[:notice] = "something went wrong, couldn't add the collaborator"
    end
  end

  def update
    @collaborator = Collaborator.new(collaborator_params)
    if @collaborator.update(collaborator_params)
      @collaborators = @wiki.collaborators
      if @collaborator.update(role: 'owner') && current_user.last_owner?(@wiki)
      else
        @collaborator.update(collaborator_params)
      end
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy
    redirect_to wikis_path, notice: "#{@collaborator.user.full_name} was successfully removed"
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :owner)
  end
end
