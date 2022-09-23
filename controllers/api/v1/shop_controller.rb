# frozen_string_literal: true

module Api
  module V1
    class ShopsController < BaseController
      actions :create, :index, :show, :destroy, :update

      private

        def resources
          Shop.send(platform_name)
        end

        def resource
          Shop.find_by!(domain: params[:domain])
        end

        def create_permitted_params
          params[:shop][:platform] = platform_name

          params.require(:shop).require(%i(name domain))
          params.require(:shop).permit(%i(default_currency domain platform name))
        end

        def update_permitted_params
          params.require(:shop).permit(%i(default_currency, name))
        end
    end
  end
end
