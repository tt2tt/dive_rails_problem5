class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string, default: '0', null: false
  end
end
