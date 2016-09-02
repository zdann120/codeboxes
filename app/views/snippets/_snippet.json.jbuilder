json.extract! snippet, :id, :box_id, :token, :haiku, :title, :code, :created_at, :updated_at
json.url box_snippet_url(snippet.box, snippet, format: :json)