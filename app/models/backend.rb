require'cgi'
require 'json'
require 'net/http'
require 'uri'

class SomeBadException < StandardError; end
# curl 'http://127.0.0.1:5984/npmjs/_design/search/_search/packagename?limit=10&q=default%3Aoffice-ui-fabric*' \
#   -H 'Connection: keep-alive' \
#   -H 'Pragma: no-cache' \
#   -H 'Cache-Control: no-cache' \
#   -H 'accept: application/json' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
#   -H 'sec-ch-ua: "Google Chrome";v="87", " Not;A Brand";v="99", "Chromium";v="87"' \
#   -H 'Content-Type: application/json' \
#   -H 'Sec-Fetch-Site: same-origin' \
#   -H 'Sec-Fetch-Mode: cors' \
#   -H 'Sec-Fetch-Dest: empty' \
#   -H 'Referer: http://127.0.0.1:5984/_utils/' \
#   -H 'Accept-Language: en-US,en;q=0.9' \
#   -H 'Cookie: hblid=KijlRWDikE0XmNgz3m39N0Wo4fFr4bBA; olfsk=olfsk8550109738064684; AuthSession=YWRtaW46NUZGNEI3NTk6Ash4hPvYSo0izlw1B-4w5ftb3XM' \
#   --compressed

class Backend
  def initialize
    @base = URI("http://#{ENV['COUCH_SERVER'] || "127.0.0.1"}:5984/npmjs")
  end

  def search query
    params = { :limit => 10, :q => "default:#{query}*" }
    search_uri = @base.clone
    search_uri.path += "/_design/search/_search/packagename"
    search_uri.query = URI.encode_www_form(params)


    http = Net::HTTP.new(search_uri.host, search_uri.port)

    req = Net::HTTP::Get.new(search_uri)
    req.basic_auth 'admin', 'password'

    res = http.request(req)

    if res.is_a?(Net::HTTPSuccess)
      transform_search_results JSON.parse(res.body)
    else
      raise SomeBadException.new
    end
  end

  def detail package_name
    fetch_uri = @base.clone
    fetch_uri.path += "/" + CGI.escape(package_name)
    http = Net::HTTP.new(fetch_uri.host, fetch_uri.port)
    req = Net::HTTP::Get.new(fetch_uri)
    req.basic_auth 'admin', 'password'
    res = http.request(req)
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      raise SomeBadException.new
    end
  end

  def transform_search_results hits
    { :total => hits['total_rows'],
      :packages => hits['rows'].map { |r| r['fields']['default'] } }
  end
end
