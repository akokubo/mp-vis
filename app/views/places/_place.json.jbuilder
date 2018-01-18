json.extract! place, :id, :name, :description, :mass, :photos, :latitude, :longitude, :collected_at, :created_at, :updated_at
json.collector place.user.name
json.url place_url(place, format: :json)
