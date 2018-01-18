class PlacesController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  # 自分で投稿した場所だけ削除可能
  before_action :correct_user,   only: [:edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    respond_to do |format|
      format.html {
        @places = Place.paginate(page: params[:page])
      }
      format.json {
        @places = Place.all
      }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
  end

  # GET /places/new
  def new
    @place = current_user.places.build(collected_at: Time.zone.now, latitude: 40.5092745, longitude: 141.4311736)
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  def create
    @place = current_user.places.build(place_params)
    if @place.save
      flash[:success] = t(:place_created)
      redirect_to @place
    else
      render :new
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params_except_photos)
      flash[:success] = t(:place_updated)
      if place_params_only_photos[:photos].present?
        photos = @place.photos.any? ? @place.photos : []
        photos += place_params_only_photos[:photos]
        @place.photos = photos
        flash[:error] = "Failed uploading photos" unless @place.save
      end
      redirect_to @place
    else
      render :edit
    end
  end

  # DELETE /places/1
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
      params.require(:place).permit(:name, :description, :mass, :latitude, :longitude, :collected_at, {photos: []})
    end

    def place_params_except_photos
      params.require(:place).permit(:name, :description, :mass, :latitude, :longitude, :collected_at)
    end

    def place_params_only_photos
      params.require(:place).permit({photos: []})
    end

    def correct_user
      # 自分が投稿した場所からidを検索
      @place = current_user.places.find_by(id: params[:id])
      redirect_to root_url if @place.nil?
    end
end
