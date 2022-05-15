json.extract! response, :id, :question, :answer, :user, :points, :created_at, :updated_at
json.url response_url(response, format: :json)
