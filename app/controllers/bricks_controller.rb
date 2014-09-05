class BricksController < ResourceController

  def self.actions
  	super - [:new, :edit]
  end

  protected

  def permitted_params
    [:quote, :author, :promote]
  end

end
