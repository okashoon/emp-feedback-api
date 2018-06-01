class AddForToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :fields, :for, :string
  end
end
