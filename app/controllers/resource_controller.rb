class ResourceController < ApplicationController

  before_action :set,     only: [:show, :edit, :update, :destroy]
  before_action :build,   only: [:new, :create]
  before_action :collect, only: :index

  before_action :persist, only: [:create, :update]
  before_action :vaporize, only: :destroy
  before_action :display

  def self.actions
    [:index, :new, :create, :show, :edit, :update, :destroy] # override me!
  end

  actions.each { |action| define_method action, ->{} }

  protected

  def set
    self.resource = model.find(params[:id])
  end

  def build
    self.resource = model.new resource_params
  end

  def collect
    self.resources = model.all
  end

  def display
    respond_with resource || resources
  end

  def persist
    resource.persisted? ? resource.update(resource_params) : resource.save
  end

  def vaporize
    resource.destroy
  end

  def permitted_params
  	model.columns.map(&:name) # override me!
  end

  private
  
  def resource
  	instance_variable_get "@#{controller_name.singularize}"
  end

  def resource=(value)
  	instance_variable_set "@#{controller_name.singularize}", value
  end

  def resources
  	instance_variable_get "@#{controller_name}"
  end

  def resources=(value)
  	instance_variable_set "@#{controller_name}", value
  end

  def resource_params
  	params.require(controller_name.singularize.to_sym).permit(permitted_params) rescue {}
  end

  def model
  	controller_name.humanize.singularize.constantize
  end

end
