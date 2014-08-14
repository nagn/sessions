class SessionsController < ApplicationController
  include SessionsHelper
  include CsvImport
  def index
    @sessions = Session.all
    respond_to do |format|
      format.html
      format.csv { render text: export_sessions(@sessions) }
    end
  end
  def new
    @session = Session.new
  end
  def show
    @session = Session.find(params[:id])
    @attended_students = Session.find(params[:id]).students
    respond_to do |format|
      format.html
      format.csv { render text: export_sessions([@session]) }
    end
  end
  def create
    @session = Session.create(session_params)
    redirect_to session_path(@session)
  end
  def destroy
    @session = Session.find(params[:id])
    Session.destroy(@session)
    redirect_to sessions_path
  end
  def add_student
    @session = Session.find(params[:id])
    @attended_students = Session.find(params[:id]).students
    if params[:selected_student]
      student = Student.find(params[:selected_student])
      Attendance.create({:student => student, :session => @session})
      respond_to do |format|
        format.js
      end
    else
      redirect_to sessions_path
    end
  end
  def remove_student
    @session = Session.find(params[:id])
    @attended_students = Session.find(params[:id]).students
    if params[:selected_student]
      student = Student.find(params[:selected_student])
      @session.students.delete(student)
      respond_to do |format|
        format.js
      end
    else
      redirect_to sessions_path
    end
  end
  def update
    redirect_to sessions_path
  end
end