class CharactersStepsController < ApplicationController
  include Wicked::Wizard

  layout "characters_steps"

  before_action :set_character
  before_action :set_resources, only: %i[show update]

  steps :klass, :species, :abilities, :physical, :notes, :personality

  def show
    @steps = steps
    @current_step = step
    render_wizard
  end

  def update
    handle_update
    render_wizard @character
  end

  def finish_wizard_path
    characters_path
  end

  private

  def handle_update
    case step
    when :klass
      @character.update(name: character_params[:name])
      @character.klasses = [Klass.find_by(name: character_params[:klass_id])] if character_params[:klass_id]&.present?
    when :species
      @character
    end
  end

  def set_resources
    case step
    when :klass
      @klasses = Klass.all
    when :species
      @races = Race.all
    when :abilities
      @ability_scores
    when :physical
      @physical_characteristic
    when :notes
      @character_note
    when :personality
      @character_personality
    else
      nil
    end
  end

  def set_character
    @character = Character.find(params[:character_id])
  end

  def character_params
    params.require(:character).permit(
      :name, :klass_id, :skin_color, :hair_color, :eye_color, :gender, :height, :weight, :age,
      :notes, :backstory, :alignment, :allies, :enemies, :faith, :lifestyle,
      :personality, :ideals, :bonds, :flaws, :species,
      :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma
    )
  end

  def main_steps
    [:klass, :species, :abilities, :physical, :notes, :personality]
  end

  def sub_steps
    [:appearance, :background]
  end
end
