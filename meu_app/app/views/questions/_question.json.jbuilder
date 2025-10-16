json.extract! question, :id, :text, :questionnaire_id, :created_at, :updated_at
json.url question_url(question, format: :json)
