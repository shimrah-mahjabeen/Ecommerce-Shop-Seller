# frozen_string_literal: true

RSpec.describe 'Shops', type: :request do
  path '/api/v1/shops' do
    parameter(name: 'Auth-Token', in: :header, type: :string,
              description: "Authentication token for communicating with API")

    get('Get all the shops for the provided Platform.') do
      tags 'Shop'

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
    end
  end

  path '/api/v1/shops/' do
    parameter(name: 'Auth-Token', in: :header, type: :string,
              description: "Authentication token for communicating with API")

    post('Create shop during the installation process.') do
      tags 'Shop'

      parameter(name: :shop, in: :body, schema: {
      type: :object,
      properties: {
        shop: {
          type: :object,
          properties: {
            name: { type: :string, description: 'Name of the shop', required: ['true'] },
            domain: { type: :string, description: 'Domain of the shop', required: ['true'] },
            default_currency: {
              type: :string,
              description: 'Store default currency i.e. USD'
            }
          }
        }
      }
    })

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

      response(422, 'Unprocessable entity') do
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

  path '/api/v1/shops/{domain}' do
    parameter(name: 'Auth-Token', in: :header, type: :string,
              description: "Authentication token for communicating with API")
    parameter(name: 'domain', in: :path, type: :string, description: "Provide domain to retrieve shop")

    get('Get a single shop’s data.') do
      tags 'Shop'

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

    put('Update a single shop’s data.') do
      tags 'Shop'

      parameter(name: :shop, in: :body, schema: {
        type: :object,
        properties: {
          shop: {
            type: :object,
            properties: {
              name: { type: :string, description: 'Name of the shop' },
              default_currency: {
                type: :string,
                description: 'Store default currency i.e. USD'
              }
            }
          }
        }
      })

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

      response(422, 'Unprocessable entity') do
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

    delete('Delete a shop and all of its associated records, usually when app is uninstalled.') do
      tags 'Shop'

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
