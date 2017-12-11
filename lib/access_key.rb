require 'rest_client'

class AccessKey
  ACCESS_KEY_URL = "https://account-key-service.herokuapp.com/v1/account".freeze

  def self.get_token(email, token)
    payload = { email: email, account_key: token}.to_json
    response = RestClient.post(ACCESS_KEY_URL, payload, headers={ "Content-Type"=>"application/json"})
    return JSON.parse(response.body).try(:[], "account_key")
  end
end