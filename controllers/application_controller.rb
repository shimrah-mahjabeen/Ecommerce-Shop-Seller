# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :verify_auth_token

  private

    def verify_auth_token
      raise CommunicationUnauthorized unless api_key
    end

    def api_key
      @api_key ||= ApiKey.find_by(token: request.headers['Auth-Token'])
    end

    def platform_name
      @platform_name ||= api_key.platform
    end
end
