json.boxes @boxes do |box|
  json.title box.title
  json.language box.box_language
  json.token box.get_jwt
end