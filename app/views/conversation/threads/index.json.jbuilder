json.array! @threads do |thread|
  json.id thread.id
  json.messages thread.messages, :id, :author_id, :content
end
