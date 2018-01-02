class PlacesController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  # 自分で投稿した場所だけ削除可能
  before_action :correct_user,   only: [:edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.paginate(page: params[:page])
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
  end

  # GET /places/new
  def new
    @place = current_user.places.build(latitude: 40.5092745, longitude: 141.4311736)
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
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

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
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
      params.require(:place).permit(:name, :description, :mass, :latitude, :longitude, :picture, :collected_at)
    end

    def correct_user
      # 自分が投稿した場所からidを検索
      @place = current_user.places.find_by(id: params[:id])
      redirect_to root_url if @place.nil?
    end
end
