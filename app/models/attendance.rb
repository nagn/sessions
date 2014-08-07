class Attendance < ActiveRecord::Base
  belongs_to :session, dependent: :destroy
  belongs_to :student, dependent: :destroy
end
