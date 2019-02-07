crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", "/users/#{current_user.id}"
  parent :root
end

crumb :card do
  link "ログアウト", "/users/#{current_user.id}/cards"
  parent :mypage
end

crumb :card_add do
  link "支払方法", "/users/#{current_user.id}/cards/new"
  parent :mypage
end

crumb :detail do
  link "商品詳細ページ", item_path
  parent :root
end

crumb :edit do
  link "本人情報の登録", "/users/#{current_user.id}/~"
  parent :mypage
end

crumb :identification do
  link "本人情報の入力", "/users/#{current_user.id}/identify"
  parent :mypage
end

crumb :logout do
  link "ログアウト", "/users/#{current_user.id}/logout"
  parent :mypage
end

crumb :trade_sell do
  link "出品した商品 - 出品中", "/users/#{current_user.id}/trade/sell"
  parent :mypage
end

crumb :trade_now do
  link "出品した商品 - 取引中", "/users/#{current_user.id}/trade/now"
  parent :mypage
end

crumb :trade_sold do
  link "出品した商品 - 売却済み", "/users/#{current_user.id}/trade/sold"
  parent :mypage
end

crumb :change do
  link "出品商品画面", "/items/@item/change"
  parent :trade_sell
end

crumb :sales do
  link "売上・振込申請", "/users/#{current_user.id}/sales"
  parent :mypage
end

crumb :buy_now do
  link "購入した商品 - 取引中", "/users/#{current_user.id}/buy/now"
  parent :mypage
end

crumb :bought do
  link "購入した商品 - 過去の取引", "/users/#{current_user.id}/bought"
  parent :mypage
end

crumb :sales do
  link "売上・振込申請", "/users/#{current_user.id}/sales"
  parent :mypage
end

crumb :search do
  link "#{params[:q][:name_cont]}", search_items_path
  parent :root
end
