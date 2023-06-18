# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable

  def initialize(url)
    @url = URI(url)
  end

  def query_params
    return {} unless @url.query

    @url.query.split('&').map do |param|
      key, value = param.split('=')
      [key, value]
    end.to_h.transform_keys(&:to_sym)
  end

  def query_param(key, default = nil)
    query_params[key] || default
  end

  def ==(other_url)
    if @url.scheme == other_url.scheme &&
       @url.host == other_url.host &&
       @url.port == other_url.port &&
       query_params == other_url.query_params
      true
    else
      false
    end
  end

  def_delegators :@url, :scheme, :host, :port
end
# END
