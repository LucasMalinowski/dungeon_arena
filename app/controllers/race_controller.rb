class RaceController < ApplicationController
  def race_modal
    if params[:subrace_id].present?
      @race = Subrace.includes(:proficiencies, :traits, :ability_scores).find(params[:subrace_id])
    else
      @race = Race.includes(:proficiencies, :traits, :ability_scores, :languages).find(params[:race_id])
    end

    respond_to do |format|
      format.html do
        render partial: "characters_steps/race_modal", locals: { race: @race }
      end
    end
  end
end