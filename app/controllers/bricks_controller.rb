class BricksController < ResourceController

  respond_to :html, :json, :js

  protected

  def permitted_params
    [:quote, :author, :promote]
  end

end
