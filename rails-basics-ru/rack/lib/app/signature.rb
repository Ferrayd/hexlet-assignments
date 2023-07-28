# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    _, _, body = @app.call(env)
    message = body.first
    body << '</br>'
    body << Digest::SHA256.hexdigest(message)
    # END
  end
end
