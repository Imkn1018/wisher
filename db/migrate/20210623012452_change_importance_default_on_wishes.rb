class ChangeImportanceDefaultOnWishes < ActiveRecord::Migration[5.2]

  def up
    change_column :wishes, :importance, :float, default: 1
  end

  def down
    change_column :wishes, :importance, :float
  end
end
