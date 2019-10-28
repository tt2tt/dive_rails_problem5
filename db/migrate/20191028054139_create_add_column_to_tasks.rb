class CreateAddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
      add_column :tasks, :deadline, :datetime, default: '0', null: false
  end
end
