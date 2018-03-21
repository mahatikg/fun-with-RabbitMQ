json.extract! submission, :id, :name, :email, :pwd, :phone, :created_at, :updated_at
json.url submission_url(submission, format: :json)
