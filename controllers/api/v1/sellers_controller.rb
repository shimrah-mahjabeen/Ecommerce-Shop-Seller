# frozen_String_literal: true

module Api
  module V1
    class SellersController < BaseController
      actions :create, :show

      private

        def resource
          @resource ||= if params[:customer_id].present?
                          shop.sellers.find_by!(customer_id: params[:customer_id])
                        else
                          shop.sellers.find(params[:id])
                        end
        end

        def new_resource
          @new_resource ||= shop.sellers.new(create_permitted_params)
        end

        def create_permitted_params
          params.require(:customer_id)

          params.permit(:customer_id)
        end
    end
  end
end
