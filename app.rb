require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'aldy_debug_kit_sqlite3'
require './show_table_action.rb'

require 'levenshtein'
enable :sessions

# 使い方
# distance = Levenshtein::normalized_distance(cmd1, cmd2)

get '/' do
  erb :index
end

post "/save_session" do
  key = params[:key]
  session[key] = params[:value]
end

post "/post_words" do
  port_word = PostWord.new
  port_word.text = params[:text]
  port_word.birth_year = params[:birth_year]
  port_word.image_url = params[:image_url]
  port_word.gender = params[:gender]
  port_word.save

  emo_words = EmoWord.all
  emo_words.each do |emo_word|
    if (emo_word.text.nil?) then
      next
    end
    distance = Levenshtein::normalized_distance(emo_word.text, text)
    if distance < 0.80 then
      port_word.emo_word_id = emo_word.id
      port_word.save
      session.clear
      redirect "/complete"
      break
    end
  end

  emo_word = EmoWord.new
  emo_word.text = port_word.text
  emo_word.save

  port_word.emo_word_id = emo_word.id
  port_word.save
  session.clear
  redirect "/complete"

end

get "/complete" do
  erb :complete
end