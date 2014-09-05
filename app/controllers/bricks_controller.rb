class BricksController < ResourceController

  protected

  def permitted_params
    [:quote, :author, :promote]
  end

end
