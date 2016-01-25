class RankingController < ApplicationController
  def have
    @counts = Have.group(:item_id).order('count_item_id desc').limit(10).count(:item_id)
    ids = @counts.keys
    @items = Item.find(ids).sort_by{|o| ids.index(o.id)}
  end

  def want
    @counts = Want.group(:item_id).order('count_item_id desc').limit(10).count(:item_id)
    ids = @counts.keys
    @items = Item.find(ids).sort_by{|o| ids.index(o.id)}
  end
end
