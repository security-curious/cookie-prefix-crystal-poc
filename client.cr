require "http/client"

tls = OpenSSL::SSL::Context::Client.new
tls.verify_mode = OpenSSL::SSL::VerifyMode::None
HTTP::Client.new "localhost", 8443, tls do |client|
  cookie = "__Secure-Name=safe; __%53ecure-Name=evil"
  headers = HTTP::Headers{"Cookie" => cookie}
  puts client.get("/", headers: headers).body
end
