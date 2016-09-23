class DbController < ApplicationController
  def create
    new_user = params[:user]
    password = params[:password]
    database  = ActiveRecord::Base.connection.current_database
    val = ActiveRecord::Base.connection.execute "SELECT 1 as val FROM pg_roles WHERE rolname='#{new_user}'"
    if val.count == 0 #can create user
      ActiveRecord::Base.connection.execute "create user #{params[:user]} password '#{password}' login"
      ActiveRecord::Base.connection.execute "GRANT ALL ON DATABASE #{database} TO #{new_user}"
      return render json: {status: 'ok'}
    else
      return render json: {status: 'failed', message: 'user already present'}, status: :unprocessable_entity
    end
  end
end
