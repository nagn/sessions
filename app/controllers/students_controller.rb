class StudentsController < ApplicationController
  include StudentsHelper
  def index
    if params[:term]
      session = Session.find(params[:session_id])
      
      @students = Student.where("name like ?", "%#{params[:term]}%")
      @students -= session.students #remove all students that have already attended
    else
      @students = Student.all
    end
    
    respond_to do |format|  
      format.html # index.html.erb  
      # Here is where you can specify how to handle the request for "/students.json"
      format.json { render :json => @students.to_json }
    end
  end
  def show
    @student = Student.find(params[:id])
  end
  def new
    @student = Student.new
  end
  def create
    @student = Student.new(student_params)
    @student.save
    redirect_to student_path(@student)
  end
end
