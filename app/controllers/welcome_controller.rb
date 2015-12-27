class WelcomeController < ApplicationController
  def index
    # @items = Item.all.order("updated_at DESC").page(params[:page]).per(30)
    @items = Item.all.joins('LEFT OUTER JOIN ownerships ON items.id = ownerships.item_id').group('items.id').order(:asin).page(params[:page]).per(32)
  end
end
