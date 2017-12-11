require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'Penrose Users Api',
        version: 'v1'
      },
      basePath: '/api',
      definitions: {
        "user" => {
          type: :object,
          properties: {
            full_name: { type: :string },
            phone_number: { type: :string },
            key: { type: :string },
            metadata: { type: :string },
            email: { type: :string },
            account_key: { type: :string, 'x-nullable': true }
          }
        }
      }
    }
  }
end
