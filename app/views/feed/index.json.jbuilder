json.array! @feed do |feed_item|
  json.uid feed_item.id
  json.type feed_item.type
  json.content feed_item.content
  json.published_at feed_item.published_at
end
