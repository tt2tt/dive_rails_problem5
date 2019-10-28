class CreateAddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :add_column_to_tasks do |t|
      t.datetime :deadline, null: false

      t.timestamps
    end
  end
end
