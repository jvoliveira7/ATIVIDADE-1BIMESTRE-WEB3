json.extract! admin_user, :id, :name, :email, :role, :created_at, :updated_at
json.url admin_user_url(admin_user, format: :json)
