class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :notes
      t.string :privacy, null: false
      t.integer :user_id, null: false
      t.boolean :completion_status, null: false, default: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
