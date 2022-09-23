# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      def index
        raise ActiveRecord::RecordNotFound, controller_name.camelize.singularize if resources.blank?

        render json: resources, each_serializer: serializer
      end

      def show
        render json: resource, each_serializer: serializer
      end

      def create
        if new_resource.save
          render json: new_resource, each_serializer: serializer, status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update(update_permitted_params)
          render json: resource, each_serializer: serializer
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if resource.destroy
          render json: resource, each_serializer: serializer
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      protected

        def serializer
          "#{model.name}Serializer".constantize
        end

        def resources
          @resources ||= model.all
        end

        def resource
          @resource ||= model.find(params[:id])
        end

        def new_resource
          @new_resource ||= model.new(create_permitted_params)
        end

        def create_permitted_params; end

        def update_permitted_params; end

        def model
          controller_name.camelize.singularize.constantize
        end

        def shop
          @shop ||= Shop.send(platform_name).find_by!(domain: params[:domain])
        end
    end
  end
end
