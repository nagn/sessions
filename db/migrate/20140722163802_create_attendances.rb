class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :session
      t.references :student
      t.timestamps
    end
  end
end
