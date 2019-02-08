require "rails_helper"

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do

    context "認証済みのユーザー" do
      before do
        @user = create(:user)
      end

    context "ログアウトしている" do

      it 'リクエスト200を返す' do
        get :new
        expect(response.status).to eq 200
      end

      it ":newテンプレートを表示する" do
        get :new
        expect(response).to render_template :new
      end

      it ":newテンプレートへリダイレクト" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている" do
      before do
        sign_in user
      end

      it ":newテンプレートを表示する" do
        get :new
        expect(response).to render_template :new
      end
    end

  end

  describe "POST #create" do

    context "有効なparamsの場合" do
      before do
        @user = attributes_for(:user)
      end

      it "リクエスト302を返す" do
        post :create, user: @user
        expect(response.status).to eq 302
      end

      it "新しいユーザーは登録される" do
        expect{ post :create, user: @user }.to change(User, :count).by(1)
      end

      it "root_pathへリダイレクトする" do
        post :create, user: @user
        expect(response).to redirect_to(root_path)
      end
    end

    context "無効なparamsの場合" do
      before do
        @invalid_user = attributes_for(:invalid_user)
      end

      it "リクエスト200を返す" do
        post :create, user: @invalid_user
        expect(response.status).to eq 200
      end

      it "新しいユーザーは登録されない" do
        expect{ post :create, user: @invalid_user }.not_to change(User, :count)
      end

      it ":newテンプレートを再表示する" do
        post :create, user: @invalid_user
        expect(response).to render_template :new
      end
    end
  end
end
