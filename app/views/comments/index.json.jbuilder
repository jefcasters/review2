json.array!(@comments) do |comment|
  json.extract! comment, :id, :value, :reviewed
  json.url comment_url(comment, format: :json)
end
