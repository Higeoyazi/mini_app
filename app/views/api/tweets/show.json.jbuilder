json.array! @comments do |comment|
  json.id comment.id
  json.user_name comment.user.name
  json.text comment.text
end