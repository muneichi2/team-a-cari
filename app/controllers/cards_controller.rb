class CardsController < ApplicationController
  protect_from_forgery except: :pay

  def index
  end

  def new

  end

  def buy_confirm
    @item = Item.find(params[:id])
  end

  def registrate
  end

  def pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    token = Payjp::Token.create({
      :card => {
      :number => params["number"],
      :cvc => params["cvc"],
      :exp_month => params["exp_month"],
      :exp_year => params["exp_year"]
     }},
     {
       'X-Payjp-Direct-Token-Generate': 'true'
     }
    )
    customer = Payjp::Customer.create(
       card: token.id,
    )
    user = User.find(current_user.id)
    user[:pay_id] = customer.id
    user.save
    redirect_to :root
  end

  def buy
    @item = Item.find(params[:id])
    if current_user.id != @item.seller_id && current_user.pay_id.present?
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    charge = Payjp::Charge.create(
    :amount => @item.price,
    :customer => current_user.pay_id,
    :currency => 'jpy',
    :capture => 'false'
    )
    else
      return redirect_to root_path, alert:"カードを登録してください。"
    end

    if charge.paid == true
      @item[:buyer_id] = current_user.id
      @item[:trade] = "取引中"
      @item.save
      redirect_to root_path, notice: "決済が完了しました。"
    else
      render :buy, alert: "予期せぬエラーが発生しました。"
    end
    end
end

