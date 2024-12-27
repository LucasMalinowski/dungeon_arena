class CharactersController < ApplicationController
  layout "characters"
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def create
    character = Character.create(user: current_user)
    redirect_to character_characters_step_path(character, :klass)
  end

  def update
    @character = Character.find(params[:id])
    @character.update(character_params)
    head :ok
  end

  # CharactersController

  def remove_token
    character = Character.find(params[:id])
    if character.token.attached?
      character.token.purge
    end
    redirect_to character_characters_step_path(character, character_params[:step].to_sym)
  end


  private

  def character_params
    params.require(:character).permit(:id, :token, :step)
  end
end
