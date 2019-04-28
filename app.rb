require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'aldy_debug_kit_sqlite3'
require './show_table_action.rb'

require 'google/apis/customsearch_v1'

# require 'levenshtein'
enable :sessions

# 使い方
# distance = Levenshtein::normalized_distance(cmd1, cmd2)

get '/' do
  erb :index
end

get '/get_images' do
  API_KEY = 'AIzaSyB8rzr7ev_zswUN07t1eSq6vd9QqEhN4M0'
  CSE_ID = '012260636148796261445:withapkaw8y'

  word = params[:word]

  searcher = Google::Apis::CustomsearchV1::CustomsearchService.new
  searcher.key = API_KEY

  results = searcher.list_cses(word, cx: CSE_ID, search_type: "image")
  items = results.items
  items = items.map!{|item| item.image.thumbnail_link}
  json items
end

get "/question" do
  erb :question
end

get "/demo" do
  erb :demo
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

  emo_words = EmoWord.where(text: port_word.text)

  if emo_words.blank?
    emo_word = EmoWord.new
    emo_word.text = port_word.text
    emo_word.save

    port_word.emo_word_id = emo_word.id
    port_word.save
  else
    emo_word = emo_words.first
    port_word.emo_word_id = emo_word.id
    port_word.save
  end

  # session.clear
  # redirect "/models"
  redirect "/complete/"+(port_word.id).to_s

end

get "/complete/:id" do
  @post_word = PostWord.find(params[:id])
  erb :complete
end

get "/share/:id" do
   @post_word = PostWord.find(params[:id])
   erb :share
end
