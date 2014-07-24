class Session < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances
  def student_list
    students.join(", ")
  end
end
