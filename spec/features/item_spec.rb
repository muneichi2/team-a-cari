require 'rails_helper'

feature 'item', type: :feature do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user, id:item_a.seller_id)}
    let(:item_a) { create(:item, seller_id: user_a.id)}
    let(:item) { create(:item) }
    let(:item_b) { build(:item) }
    let(:item_image) {create(:item_image, item_id: item_a.id)}
    background do
      login_as user_a
      allow(Payjp::Customer).to receive(:retrieve).and_return(PayjpMock.prepare_valid_charge)
      allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.prepare_valid_charge)
      allow(Payjp::Charge).to receive(:create).and_return(PayjpMock.prepare_valid_charge)
    end

    scenario 'index画面' do
      visit root_path
      click_on "出品"
      visit new_item_path
      item_b
      click_on "出品する"
    end

    scenario '出品画面' do
      visit new_item_path
      attach_file "出品画像", "/spec/images/spec.jpg"
      fill_in '商品名', with: "テストタイトル"
      fill_in '商品の説明', with: "テスト"
      select 'レディーズ', from: "カテゴリー"
      select 'トップス', from: "カテゴリー"
      select 'ポロシャツ', from: "カテゴリー"
      select '未使用に近い', from: "商品の状態"
      select '送料込み(出品者負担)', from: "配送料の負担"
      select '大阪府', from: "配送元の地域"
      select '1~2日で発送', from: "発送までの日数"
      fill_in '価格', with: 5000
      expect(page).to have_content "￥4,500"
    end

    scenario 'item詳細画面にアクセス' do
      item_image = create(:item_image, item_id: item_a.id)
      visit item_path(item_a)
      expect(page).to have_content "出品者"
      expect(page).to have_content item_a.name
      category = Category.find(item_a.category_id)
      expect(page).to have_content category.name
      expect(page).to have_content Brand.find(item_a.brand_id).name
      expect(page).to have_content Size.find(item_a.size_id).name
      expect(page).to have_content item_a.status
      expect(page).to have_content item_a.burden
      expect(page).to have_content item_a.delivery_method
      expect(page).to have_content item_a.prefecture
      expect(page).to have_content item_a.delivery_day
      expect(page).to have_content item_a.describe
    end

    scenario "購入画面にアクセス" do
      item_image
      visit "/items/#{item_a.id}/buy_confirm"
      click_on "購入する"
    end

    scenario "購入した商品" do
      user_a
      item_c = create(:item, seller_id: user_a.id, buyer_id: user_b.id)
      visit "/users/#{user_a.id}/buy/now"
      expect(page).to have_content item_c.name
    end

    scenario "マイページへアクセス" do
      visit root_path
      visit user_path(user_a)
      expect(page).to have_content user_a.nickname
    end

    scenario "出品中の画面にアクセス" do
      user_a
      visit "/users/#{user_a.id}/trade/sell"
    end
end
