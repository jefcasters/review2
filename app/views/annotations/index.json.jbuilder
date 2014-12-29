json.annotations @annotations do |comment|
  if comment.json != 'null'
    json.(comment, :json)
    json.(comment, :id)
    json.(comment, :value)
    json.(comment, :comment_name)
  end
end


