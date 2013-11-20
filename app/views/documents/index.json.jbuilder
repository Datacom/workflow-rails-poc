json.array!(@documents) do |document|
  json.extract! document, :name
  json.url document_url(document, format: :json)
end
