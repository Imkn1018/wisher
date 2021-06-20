class AddPurposeToWishes < ActiveRecord::Migration[5.2]
  def change
    add_column :wishes, :purpose, :string
    add_column :wishes, :action, :string
  end
end
