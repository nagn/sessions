class SessionsController < ApplicationController
  include SessionsHelper
  def index
    @sessions = Session.all
  end
  def new
    @session = Session.new
  end
  def show
    #flash.notice = "Updated!"
    @session = Session.find(params[:id])
    @attended_students = Session.find(params[:id]).students
  end
  def create
    @session = Session.new(session_params)
    @session.save
    redirect_to session_path(@session)
  end
  def update
    #append student to list
    @session = Session.find(params[:id])
    @attended_students = Session.find(params[:id]).students
    if params[:term]
      student = Student.find(params[:selected_student])
      attendance = Attendance.new({:student => student, :session => @session})
      attendance.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to sessions_path
    end
  end
end