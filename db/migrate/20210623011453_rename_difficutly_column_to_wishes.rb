class RenameDifficutlyColumnToWishes < ActiveRecord::Migration[5.2]
  def change
    rename_column :wishes, :difficutly, :importance
  end
end
