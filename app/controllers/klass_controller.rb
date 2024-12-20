class KlassController < ApplicationController
  def klass_modal
    @klass = Klass.find(params[:klass_id])

    respond_to do |format|
      format.html do
        render partial: "characters_steps/klass_modal", locals: { klass: @klass }
      end
    end
  end
end