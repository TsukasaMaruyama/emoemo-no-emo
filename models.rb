require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class PostWord < ActiveRecord::Base
end

class EmoWord <  ActiveRecord::Base
end
