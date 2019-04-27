class CreateEmoWords < ActiveRecord::Migration[5.2]
  def change
    create_table :emo_words do |t|
      t.string :text
      t.timestamps null: false
    end
  end
end
