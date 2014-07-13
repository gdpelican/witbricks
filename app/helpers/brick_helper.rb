module BrickHelper

  def render_partial(partial)
  	escape_javascript render(partial, brick: @brick)
  end

end