class CreateUsersFields < ActiveRecord::Migration[5.1]
  def change
    create_table :users_fields do |t|
      t.integer :user_id
      t.integer :field_id
      t.datetime :date
      t.integer :state
    end
  end
end
