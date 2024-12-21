class CharactersStepsController < ApplicationController
  include Wicked::Wizard

  layout "characters"

  before_action :set_character

  steps :klass, :species, :abilities, :physical, :notes, :personality

  def show
    @klasses = Klass.all
    @steps = steps
    @current_step = step
    render_wizard
  end

  def update
    @character.update(character_params)
    render_wizard @character
  end

  def finish_wizard_path
    characters_path
  end

  private

  def set_character
    @character = Character.find(params[:character_id])
  end

  def character_params
    params.require(:character).permit(
      :name, :klass, :skin_color, :hair_color, :eye_color, :gender, :height, :weight, :age,
      :notes, :backstory, :alignment, :allies, :enemies, :faith, :lifestyle,
      :personality, :ideals, :bonds, :flaws, :species,
      :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma
    )
  end
end
