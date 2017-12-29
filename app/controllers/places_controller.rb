class PlacesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  # 自分で投稿した場所だけ削除可能
  before_action :correct_user,   only: :destroy

  def create
    @place = current_user.places.build(place_params)
    if @place.save
      flash[:success] = t(:place_created)
      redirect_to root_url
    else
      # homeを表示させるのに、@feed_itemsが必要なため
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @place.destroy
    flash[:success] = t(:place_deleted)
    # 削除を実行したページ(なければトップページ)にリダイレクト
    # redirect_to request.referrer || root_url
    # 上記と同じ
    redirect_back(fallback_location: root_url)
  end

  private

    def place_params
      params.require(:place).permit(:content, :picture)
    end

    def correct_user
      # 自分が投稿した場所からidを検索
      @place = current_user.places.find_by(id: params[:id])
      redirect_to root_url if @place.nil?
    end
end
