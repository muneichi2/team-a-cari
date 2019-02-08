require "rails_helper"

RSpec.describe User, type: :model do

  describe "#create" do

    it "nickname, email, password, password_confirmationが存在すれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nicknameが空の場合は登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "emailが空の場合は登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "passwordが空の場合は登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

     it "password_confirmationが空の場合は登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "nicknameが21文字以上の場合は登録できない" do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

    it "既に登録されているemailが存在する場合は登録できない" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "passwordが5文字以下の場合は登録できない" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

  end
end
