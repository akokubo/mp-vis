class PhotosController < ApplicationController
  before_action :correct_user

  def create
    add_more_photos(photos_params[:photos])
    flash[:error] = "Failed uploading photos" unless @place.save
    redirect_back(fallback_location: root_url)
  end

  def destroy
    remove_photo_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting photo" unless @place.save
    redirect_back(fallback_location: root_url)
  end

  private

    def correct_user
      # 自分が投稿した場所からidを検索
      @place = current_user.places.find_by(id: params[:place_id])
      redirect_to root_url if @place.nil?
    end

    def add_more_photos(new_photos)
      photos = @place.photos 
      photos += new_photos
      @place.photos = photos
    end

    def remove_photo_at_index(index)
      remain_photos = @place.photos # copy the array
      deleted_photo = remain_photos.delete_at(index) # delete the target photo
      deleted_photo.try(:remove!) # delete photo from S3
      @place.photos = remain_photos # re-assign back
    end

    def photos_params
      params.require(:place).permit({photos: []}) # allow nested params as array
    end
end
