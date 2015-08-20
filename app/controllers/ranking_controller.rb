class RankingController < ApplicationController
  def have
    ids = Have.group(:item_id).order('count_item_id desc').limit(10).count(:item_id).keys
    @items = Item.find(ids).sort_by{|o| ids.index(o.id)}
  end

  def want
    ids = Want.group(:item_id).order('count_item_id desc').limit(10).count(:item_id).keys
    @items = Item.find(ids).sort_by{|o| ids.index(o.id)}
  end
end
