require "http/server"

server = HTTP::Server.new do |context|
  cookie = context.request.cookies["__Secure-Name"]?.try &.value
  context.response.content_type = "text/plain"
  context.response.print "Cookie Value: #{cookie}"
end

tls = OpenSSL::SSL::Context::Server.from_hash({
  "key" => "key.pem",
  "cert" => "cert.pem"
})
address = server.bind_tls "127.0.0.1", 8443, tls
puts "Listening on https://#{address}"
server.listen
