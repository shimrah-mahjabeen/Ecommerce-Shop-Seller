# frozen_string_literal: true

RSpec.describe 'Sellers', type: :request do
  path '/api/v1/sellers' do
    parameter(name: 'Auth-Token', in: :header, type: :string,
              description: "Authentication token for communicating with API")
    parameter(name: :seller, in: :body, schema: {
      type: :object,
      properties: {
        domain: { type: :string, description: 'Domain of the shop' },
        customer_id: { type: :integer, description: 'Customer id from the platform' }
      }
    })

    post('Create a new seller.') do
      tags 'Seller'

      response(201, 'Created') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Not found') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/sellers/{customer_id}' do
    parameter(name: 'Auth-Token',
              in: :header,
              type: :string,
              description: "Authentication token for communicating with API")

    parameter(name: 'customer_id',
              in: :path,
              type: :integer,
              required: ['true'],
              description: 'Customer id from the platform')

    parameter(name: 'domain', in: :query, type: :string, required: true, description: 'Domain of the shop')
    parameter(name: 'id',
              in: :query,
              type: :integer,
              description: 'Seller id of the customer that is stored in database')

    get('Retrieve a seller’s information.') do
      tags 'Seller'

      response(200, 'Successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Not found') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
