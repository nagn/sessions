class Student < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_many :sessions, through: :attendances
  def to_s
    name
  end
end
