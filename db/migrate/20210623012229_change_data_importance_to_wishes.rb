class ChangeDataImportanceToWishes < ActiveRecord::Migration[5.2]
  def change
    change_column :wishes, :importance, :float
  end
end
