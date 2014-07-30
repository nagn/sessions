class SessionsController < ApplicationController
  include SessionsHelper
  def index
    @sessions = Session.all
  end
  def new
    @session = Session.new
  end
  def show
    @session = Session.find(params[:id])
    @attended_ids = Session.find(params[:id]).students
  end
  def create
    @session = Session.new(session_params)
    @session.save
    redirect_to session_path(@session)
  end
  def update
    
  end
end