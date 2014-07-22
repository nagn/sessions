class AddKindToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :kind, :string
  end
end
