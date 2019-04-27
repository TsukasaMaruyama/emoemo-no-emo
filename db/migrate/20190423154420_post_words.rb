class PostWords < ActiveRecord::Migration[5.2]
  def change
    create_table :post_words do |t|
      t.string :text
      t.string :image_url
      t.integer :emo_word_id
      t.integer :birth_year
      t.timestamps null: false
    end
  end
end
