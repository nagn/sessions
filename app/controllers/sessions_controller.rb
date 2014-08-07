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
    @attended_students = Session.find(params[:id]).students
  end
  def create
    @session = Session.new(session_params)
    @session.save
    redirect_to session_path(@session)
  end
  def add_student
    @session = Session.find(params[:id])
    @attended_students = Session.find(params[:id]).students
    if params[:selected_student]
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