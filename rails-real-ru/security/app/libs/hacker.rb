# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'uri'

class Hacker
  def self.hack(email, password)
    host = 'rails-collective-blog-ru.hexlet.app'
    uri = URI("https://#{host}/users/sign_up")
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE 

    get_request = Net::HTTP::Get.new(uri)
    response = http.request(get_request)
    
    cookie = response.response['set-cookie']
    doc = Nokogiri::HTML(response.body)
    token = doc.at('meta[name="csrf-token"]')&.[]('content') || 
            doc.at('input[name="authenticity_token"]')&.[]('value')
    
    raise "CSRF token not found" unless token

    post_uri = URI("https://#{host}/users")
    form_data = {
      'user[email]' => email,
      'user[password]' => password,
      'authenticity_token' => token,
      'commit' => 'Sign up'
    }

    post_request = Net::HTTP::Post.new(post_uri)
    post_request['Cookie'] = cookie
    post_request['Content-Type'] = 'application/x-www-form-urlencoded'
    post_request['User-Agent'] = 'Mozilla/5.0' 
    post_request.body = URI.encode_www_form(form_data)

    response = http.request(post_request)
    puts "Response code: #{response.code}"
    puts "Response body: #{response.body}" 
    
    response
  end
end
