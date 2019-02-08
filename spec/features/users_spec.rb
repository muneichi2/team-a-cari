require "rails_helper"

RSpec.describe "UserFeature" do

  describe "Facebookを経由してログインする" do

    before do
      OmniAuth.config.mock_auth[:facebook] = nil
      Rails.application.env_config['omniauth.auth'] = facebook_mock
      visit root_path
      click_link "ログイン"
    end

    it "Facebookを経由して新規登録する" do
      expect{
        click_link "Facebookでログイン"
      }.to change(User, :count).by(1)
    end

    it "既に登録されているユーザーの場合は登録されない" do
      click_link "Facebookでログイン"
      click_link "ログアウト"
      click_link "ログイン"
      expect{
        click_link "Facebookでログイン"
      }.not_to change(User, :count)
    end

  end

  describe "Googleを経由してログインする" do

    before do
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      Rails.application.env_config['omniauth.auth'] = google_mock
      visit root_path
      click_link "ログイン"
    end

    it "Googleを経由して新規登録する" do
      expect{
        click_link "Googleでログイン"
      }.to change(User, :count).by(1)
    end

    it "既に登録されているユーザーの場合は登録されない" do
      click_link "Googleでログイン"
      click_link "ログアウト"
      click_link "ログイン"
      expect{
        click_link "Googleでログイン"
      }.not_to change(User, :count)
    end

  end
end
