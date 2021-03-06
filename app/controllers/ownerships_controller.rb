# -*- coding: utf-8 -*-
class OwnershipsController < ApplicationController
  before_action :logged_in_user

  def create
    if params[:asin]
      @item = Item.find_or_initialize_by(asin: params[:asin])
      # itemsテーブルに存在しない場合はAmazonのデータを登録する。
      if @item.new_record?
        begin
          response = Amazon::Ecs.item_lookup(params[:asin], response_group: 'Medium', country: 'jp')
        rescue Amazon::RequestError => e
          return render js: "alert('Amazonとの通信エラーが発生しました。[#{e.message}]')"
        end

        amazon_item = response.items.first
        unless amazon_item
          return render js: "alert('ASIN #{params[:asin]} が見つかりませんでした。"
        end
        @item.title = amazon_item.get('ItemAttributes/Title')
        @item.small_image = amazon_item.get("SmallImage/URL")
        @item.medium_image = amazon_item.get("MediumImage/URL")
        @item.large_image = amazon_item.get("LargeImage/URL")
        @item.detail_page_url = amazon_item.get("DetailPageURL")
        @item.raw_info = amazon_item.get_hash
        @item.save!
      end
    else
      @item = Item.find(params[:item_id])
    end

    if params[:type] == "Have"
      current_user.have @item
    elsif params[:type] == "Want"
      current_user.want @item
    end
  end

  def destroy
    @item = Item.find(params[:item_id])

    if params[:type] == "Have"
      current_user.unhave @item
    elsif params[:type] == "Want"
      current_user.unwant @item
    end
  end
end
