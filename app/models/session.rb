class Session < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_many :students, through: :attendances
  def student_list
    students.join(", ")
  end
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |session|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
end
