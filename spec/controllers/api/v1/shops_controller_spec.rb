# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ShopsController, type: :controller do
  before :each do
    allow(controller).to(receive(:api_key).and_return(api_key))
  end

  describe '#index' do
    context 'fetch all shops' do
      let(:api_key) { create(:api_key, :platform_a) }
      let(:shop) { create(:shop, :platform_a) }

      it 'will return all created shops' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).not_to(be_nil)
      end
    end
  end

  describe '#create' do
    let(:api_key) { create(:api_key, :platform_a) }

    context 'when params are missing' do
      let(:payload) do
      {
        shop:{
          name: Faker::Name.name,
          platform: api_key.platform,
          default_currency: 'USD',
        }
      }
      end

      it 'will return exception domain is missing' do
        post :create, params: payload

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('Missing parameter domain')
      end
    end

    context 'when params are present' do
      let(:payload) do
      {
        shop:{
        name: Faker::Name.name,
        platform: api_key.platform,
        domain: Faker::Name.name.delete(' ').underscore,
        default_currency: 'USD',
        }
      }
      end

      it 'will create a shop' do
        post :create, params: payload

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).not_to(be_nil)
      end
    end
  end

  describe '#show' do
    let(:api_key) { create(:api_key, :platform_a) }

    context 'when shop is not present' do
      let(:payload) do
        {
          domain: nil
        }
      end

      it 'will return exception' do
        get :show, params: payload

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Record(s) not found: Shop')
      end
    end

    context 'shop is present' do
      let(:shop) { create(:shop, :platform_a) }
      let(:payload) do
        {
          domain: shop.domain
        }
      end

      it 'will return shop' do
        get :show, params: payload

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).not_to(be_nil)
      end
    end
  end


  describe '#update' do
    let(:api_key) { create(:api_key, :platform_a) }
    let(:shop) { create(:shop, :platform_a) }

    context 'when params are missing' do
      let(:payload) do
      {
        id: shop.id
      }
      end

      it 'will return exception domain is missing' do
        put :update, params: payload

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('Missing parameter shop')
      end
    end

    context 'when shop not found' do
      let(:payload) do
      {
        id: Shop.maximum(:id).to_i + 1
      }
      end

      it 'will return exception domain is missing' do
        put :update, params: payload

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Record(s) not found: Shop')
      end
    end

    context 'when params are present' do
      let(:payload) do
      {
        shop:{
          name: Faker::Name.name,
          store_default_currency: 'USD',
        },
        id:shop.id
      }
      end

      it 'will update shop' do
        put :update, params: payload

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#destroy' do
    let(:api_key) { create(:api_key, :platform_a) }

    context 'when shop is not present' do

      let(:payload) do
        {
          id: Shop.maximum(:id).to_i + 1
        }
      end

      it 'will return exception' do
        delete :destroy, params: payload

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Record(s) not found: Shop')
      end
    end

    context 'when shop is found' do
      let(:shop) { create(:shop, :platform_a) }
      let(:payload) do
        {
          id: shop.id
        }
      end

      it 'will destroy shop' do
        delete :destroy, params: payload

        expect(Shop.find(payload[:id])).to be_nil
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(payload[:id])
      end
    end
  end
end
