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
  end
  def create
    @session = Session.new(session_params)
    @session.save
    redirect_to session_path(@session)
  end
end
