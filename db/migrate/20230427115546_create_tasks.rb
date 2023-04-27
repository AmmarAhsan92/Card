class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, default: ""
      t.string :description, default: ""
      t.boolean :is_completed, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
