class ContactsScopedUniqueness < ActiveRecord::Migration
  def change
    add_index(:contacts, [:user_id, :email], unique: true)
  end
end
