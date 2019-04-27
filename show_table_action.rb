
    get '/models' do
      @models = AldyDebugKitSqlite3.getTables
      erb :aldy_show_sqlite3_tables
    end
    
