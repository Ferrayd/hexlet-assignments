# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    request = Rack::Request.new(env)
    locale = extract_locale_from_header(request.env['HTTP_ACCEPT_LANGUAGE'])
    I18n.locale = locale || I18n.default_locale
    
    @app.call(env)
  end

  private

  def extract_locale_from_header(header)
    return nil if header.nil? || header.strip.empty?

    locales = header.split(',').map do |l|
      l.split(';q=').first.strip
    end
    
    locales.find { |l| I18n.available_locales.map(&:to_s).include?(l) }
  end

  # END
end
