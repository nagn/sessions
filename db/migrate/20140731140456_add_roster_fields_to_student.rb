class AddRosterFieldsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :role, :string
    add_column :students, :first_name, :string
    add_column :students, :nick_name, :string
    add_column :students, :goes_by, :string
    add_column :students, :last_name, :string
    add_column :students, :official_full_name, :string
    add_column :students, :net_id, :string
    add_column :students, :cell, :string
    add_column :students, :yale_email, :string
    add_column :students, :yale_email_alias, :string
    add_column :students, :non_yale_email, :string
    add_column :students, :queue, :string
    add_column :students, :old_queue, :string
    add_column :students, :college, :string
    add_column :students, :class_year, :integer
    add_column :students, :birthday, :string
    add_column :students, :other, :text
  end
end
