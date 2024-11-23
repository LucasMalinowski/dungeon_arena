class CharactersController < ApplicationController
  layout "characters"
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def create
    character = Character.create
    redirect_to character_characters_step_path(character, :klass)
  end
end
