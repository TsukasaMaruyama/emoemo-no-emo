require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'aldy_debug_kit_sqlite3'
require './show_table_action.rb'

require 'levenshtein'

# 使い方
# distance = Levenshtein::normalized_distance(cmd1, cmd2)

get '/' do
  erb :index
end

post "/post_words" do
  port_word = PostWord.new
  port_word.text = params[:text]
  port_word.birth_year = params[:birth_year]
  port_word.save

  EmoWord.reindex
  emo_words = EmoWord.search "2% #{params[:text]}"
  # emo_words.each do |emo_word|
  #   if (emo_word.text.nil?) then
  #     next
  #   end
  #   distance = Levenshtein::normalized_distance(emo_word.text, text)
  #   if distance < 0.99 then
  #     port_word.emo_word_id = emo_word.id
  #     port_word.save
  #     redirect "/"
  #     break
  #   end
  # end

  # if emo_words.empty? then
  #   emo_word = EmoWord.new
  #   emo_word.text = params[:text]
  #   emo_word.save
  # else
  #    emo_word = emo_words[0]
  # end

  # port_word.emo_word_id = emo_word.id
  # port_word.save



  redirect '/'
end