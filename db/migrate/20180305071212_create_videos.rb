class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.text :description
      t.integer :views
      t.string :tag
      t.string :channel
      t.string :category

      t.timestamps
    end
  end
end
