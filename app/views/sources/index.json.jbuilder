json.array!(@sources) do |source|
  json.extract! source, :name, :url, :weight
  json.url source_url(source, format: :json)
end
