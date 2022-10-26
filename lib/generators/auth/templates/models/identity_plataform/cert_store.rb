# frozen_string_literal: true

require 'net/http'

module IdentityPlatform
  #= DecodeIdentityToken::CertStore
  #
  # This class is used by the DecodeIdentityToken service to retrieve and store
  # the certificates used to properly decode tokens issued by Google Cloud
  # Identity Platform
  class CertStore
    extend MonitorMixin

    CERTS_PATH = '/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'
    CERTS_EXPIRY = 3600

    mattr_reader :certs_last_refresh

    def self.client
      @client ||= Faraday.new('https://www.googleapis.com') do |f|
        f.response :json # decode response bodies as JSON
        f.adapter :net_http
      end
    end

    def self.certs_cache_expired?
      return true unless certs_last_refresh

      Time.current > certs_last_refresh + CERTS_EXPIRY
    end

    def self.certs
      refresh_certs if certs_cache_expired?
      @@certs
    end

    def self.fetch_certs
      client.get(CERTS_PATH).tap do |response|
        raise Error, 'Failed to fetch certs' unless response.success?
      end
    end

    def self.refresh_certs
      synchronize do
        return unless (res = fetch_certs)

        new_certs = res.body.transform_values do |cert_string|
          OpenSSL::X509::Certificate.new(cert_string)
        end

        (@@certs ||= {}).merge! new_certs
        @@certs_last_refresh = Time.current
      end
    end
  end
end
