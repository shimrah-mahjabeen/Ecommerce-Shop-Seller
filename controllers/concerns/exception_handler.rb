# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class CommunicationUnauthorized < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |resource|
      render json: { message: I18n.t('application.exceptions.record_not_found',
                                     resource: resource.model.presence || resource) }, status: :not_found
    end

    rescue_from CommunicationUnauthorized do |_e|
      render json: { message: I18n.t('application.exceptions.unauthorized_communication') }, status: :unauthorized
    end
  end
end
