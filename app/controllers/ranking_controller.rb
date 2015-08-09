class RankingController < ApplicationController
  def have
    ranking = Have.group(:item_id).order('count_item_id desc').count(:item_id)
    ids = ranking.collect{|k,v| k }
    @items = Item.find(ids)
  end

  def want
    ranking = Want.group(:item_id).order('count_item_id desc').count(:item_id)
    ids = ranking.collect{|k,v| k }
    @items = Item.find(ids)
  end
end
