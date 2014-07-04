json.array!(@hours) do |hour|
  json.extract! hour, :id
  json.url hour_url(hour, format: :json)
end
