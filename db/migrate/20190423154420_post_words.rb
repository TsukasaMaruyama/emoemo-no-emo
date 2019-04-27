class PostWords < ActiveRecord::Migration[5.2]
  def change
    create_table :post_words do |t|
      t.string :text
      t.string :image_url
      t.integer :emo_word_id
      t.integer :birth_year
      t.integer :gender
      t.timestamps null: false
    end
  end
end
