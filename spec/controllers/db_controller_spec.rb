require 'rails_helper'

RSpec.describe DbController, type: :controller do
  describe "GET #create" do
    it "returns http success" do
      post :create, {user: 'somebody1', password: 'somepass'}
      expect(response).to have_http_status(:success)
      val = ActiveRecord::Base.connection.execute "SELECT 1 as val FROM pg_roles WHERE rolname='somebody1'"
      expect(val.count).to eql(1)
    end
  end
end
