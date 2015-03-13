json.array!(@flats) do |flat|
  json.extract! flat, :id, :city, :country, :address, :description, :price, :rules
  json.url flat_url(flat, format: :json)
end
