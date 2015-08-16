class RankingController < ApplicationController
  def have
#    ranking = Have.group(:item_id).order('count_item_id desc').count(:item_id)
#    ids = ranking.collect{|k,v| k }
    ids = Have.group(:item_id).order('count_item_id desc').limit(10).count(:item_id).keys
    @items = Item.find(ids)
  end

  def want
#    ranking = Want.group(:item_id).order('count_item_id desc').count(:item_id)
#    ids = ranking.collect{|k,v| k }
    ids = Want.group(:item_id).order('count_item_id desc').limit(10).count(:item_id).keys
    @items = Item.find(ids)
  end
end
