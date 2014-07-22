class StudentsController < ApplicationController
  include StudentsHelper
  def index
    @students = Student.all
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
