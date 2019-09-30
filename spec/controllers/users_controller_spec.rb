require 'rails_helper'

describe UsersController, type: :controller do

  describe 'GET #edit' do
    it "renders the :edit template" do
      get :edit, params: { id: user }
      # factoriesの設定
      expect(response).to render_template :edit
    end
  end

end
