class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.string :tag_name
      t.string :tag_image_id

      t.timestamps
    end
  end
end
