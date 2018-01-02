json.extract! place, :id, :name, :description, :mass, :picture, :latitude, :longitude, :collected_at, :created_at, :updated_at
json.url place_url(place, format: :json)