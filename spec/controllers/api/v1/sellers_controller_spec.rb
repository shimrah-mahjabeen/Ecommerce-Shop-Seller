
require 'rails_helper'

RSpec.describe Api::V1::SellersController, type: :controller do
  before :each do
    allow(controller).to(receive(:api_key).and_return(api_key))
  end

  describe '#show' do
    let(:api_key) { create(:api_key, :platform_a) }
    let(:shop) { create(:shop, :platform_a) }
    let(:seller) { create(:seller, shop: shop) }
  end

    context 'when domain not found for authenticated platform' do
      let(:api_key) { create(:api_key, :platform_b) }

      it 'will return exception' do
        post :create, params: seller.customer_id

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Record(s) not found: Shop')
      end
    end

    context 'when domain found for authenticated platform' do
      context 'when params are missing' do
        it 'will return exception' do
          post :create, params:  {}

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['message']).to eq('Missing parameter customer_id')
        end
      end

      context 'when params are present' do
        context 'using customer_id' do
          context 'when seller does not exist' do
            it 'will return exception' do
              post :create, params: seller.customer_id + 1

              expect(response).to have_http_status(:unprocessable_entity)
              expect(JSON.parse(response.body)['message']).to include('Record(s) not found: Seller')
            end
          end

          context 'when seller exists' do
            it 'will return created seller object' do
              post :create, params: seller.customer_id

              expect(response).to have_http_status(:created)
              expect(JSON.parse(response.body)['customer_id']).to eq(payload[:customer_id])
            end
          end
        end

        context 'using seller_id' do
          context 'when seller does not exist' do
            it 'will return exception' do
              post :create, params: seller.maximum(:id).to_i + 1

              expect(response).to have_http_status(:unprocessable_entity)
              expect(JSON.parse(response.body)['message']).to include('Record(s) not found: Seller')
            end
          end

          context 'when seller exists' do
            it 'will return created seller object' do
              post :create, params: seller.maximum(:id).to_i

              expect(response).to have_http_status(:created)
              expect(JSON.parse(response.body)['customer_id']).to eq(payload[:customer_id])
            end
          end
        end
      end
    end
  end

  describe '#create' do
    let(:api_key) { create(:api_key, :platform_a) }
    let(:shop) { create(:shop, :platform_a) }
    let(:payload) do {
        customer_id: Faker::Number.number(digits: 13),
        domain: shop.domain
      }
    end

    context 'when domain not found for authenticated platform' do
      let(:api_key) { create(:api_key, :platform_b) }

      it 'will return exception' do
        post :create, params: payload

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Record(s) not found: Shop')
      end
    end

    context 'when domain found for authenticated platform' do
      context 'when params are missing' do
        it 'will return exception' do
          post :create, params:  payload.except(:customer_id)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['message']).to eq('Missing parameter customer_id')
        end
      end

      context 'when params are present' do
        let(:seller) { create(:seller, shop: shop) }

        context 'when seller exists' do
          it 'will return exception' do
            post :create, params: payload.merge(customer_id: seller.customer_id)

            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)['message']).to include('Customer has already been taken')
          end
        end

        context 'when seller is created' do
          it 'will return created seller object' do
            post :create, params: payload

            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)['customer_id']).to eq(payload[:customer_id])
          end
        end
      end
    end
  end
end
