require 'swagger_helper'

describe "Users Api", type: :request do
  path '/users' do
    post 'create user' do
      tags 'users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :body, in: :body, type: :object, required: true, schema: {
        type: :object,
        properties: {
          full_name: { type: :string },
          password: { type: :string },
          email: { type: :string },
          phone_number: { type: :string },
          key: { type: :string },
          metadata: { type: :string },
        },
        required: [
          'password', 'email', 'key', 'phone_number'
        ]
      }

      response '201', 'users api' do
        let(:body) do
        {
          full_name: FFaker::Name.name,
          phone_number: FFaker::PhoneNumber.short_phone_number,
          key: "12345678",
          email: FFaker::Internet.email,
          metadata: FFaker::Lorem.sentence,
          password: FFaker::Lorem.word
        }
        end

        schema '$ref' => '#/definitions/user'
        run_test!
      end

      response '422', 'users api' do
        let(:body) do
          {
            full_name: FFaker::Name.name,
            key: "12345678",
            email: FFaker::Internet.email,
            metadata: FFaker::Lorem.sentence,
            password: FFaker::Lorem.word
          }
        end

        schema type: :object, properties: {
          success: { type: :boolean },
          errors: { type: :array }
        }

        run_test!
      end
    end
  end

  path '/users?query={query}' do

    get 'users api' do
      tags 'users'
      produces 'application/json'
      parameter name: :query, in: :path, type: :string

      response '200', 'get users' do
        schema type: :object, properties: {'users': { type: :array, items: { '$ref' => '#/definitions/user' }}}
        let!(:user) { create(:user, email: 'juan@gmail.com') }
        let(:query) { user.email }

        run_test!
      end
    end
  end
end
