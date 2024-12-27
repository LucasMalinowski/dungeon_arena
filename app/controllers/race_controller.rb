class RaceController < ApplicationController
  def race_modal
    @race = Race.includes(:proficiencies, :traits, :ability_scores, :languages).find(params[:race_id])

    respond_to do |format|
      format.html do
        render partial: "characters_steps/race_modal", locals: { race: @race }
      end
    end
  end
end