class CreateChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :change_column_null_tasks do |t|

      change_column :tasks, :name, :string, null: false
      change_column :tasks, :detail, :text, null: false

      t.timestamps
    end
  end
end
