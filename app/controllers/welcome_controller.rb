class WelcomeController < ApplicationController
  def index
    # @items = Item.all.order("updated_at DESC").page(params[:page]).per(30)
    @items = Item.all.order(:asin).page(params[:page]).per(30)
  end
end
