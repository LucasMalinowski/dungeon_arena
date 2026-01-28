class ApplicationController < ActionController::Base
  include Turbo::Native::Navigation
  before_action :set_variant

  private

  def set_variant
    if turbo_native_app?
      request.variant = [:turbo_native, :phone]
    end
  end
end
