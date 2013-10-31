require 'net/http'
require 'net/https'

uri = URI.parse("http://google.com/")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth("username", "password")
response = http.request(request)