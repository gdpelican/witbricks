class Brick < ActiveRecord::Base
  validates_presence_of :quote, :author

  attr_accessor :promote

  default_scope { order order: :asc }

  before_create :set_order
  before_update :set_order, if: :promote

  def self.next_order
  	(maximum(:order) || 0) + 1
  end

  private

  def set_order
  	self.order = self.class.next_order
  end
end
