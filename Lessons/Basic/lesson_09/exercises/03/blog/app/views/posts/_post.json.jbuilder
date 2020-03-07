json.extract! post, :id, :subject, :content, :published_on, :created_at, :updated_at
json.url post_url(post, format: :json)
