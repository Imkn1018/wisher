class ChangeIsCompletedDefaultOnWishes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :wishes, :isCompleted, from: true, to: false, null: false
  end
end
