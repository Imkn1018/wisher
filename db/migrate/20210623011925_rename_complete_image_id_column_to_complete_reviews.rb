class RenameCompleteImageIdColumnToCompleteReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :complete_reviews, :complete_image_id, :complete_image
  end
end
