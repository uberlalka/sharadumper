require "open-uri"
require "net/http"

puts "SharaDumper v.1.0"
File.readlines('Resources.txt').each do |line|
  if line.to_s =~ /#{/mr\[(.*)\] = {TId: ., Url: \"(.*.(swf|png))\"(?:(};|, V: \"(.*)\"};))/i}/ then
    url = URI.parse('http://sharaball.ru/fs/'+$2)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
      if req.request_head(url.path).code == "200" then
      open('fs/'+ $2, 'wb') do |file|
          puts "Downloading | 200 |"+ $2 + "\n"
          file << open('http://sharaball.ru/fs/'+$2).read || ""
        end
      else
        puts "Skipping | 404 | "+ $2 + "\n"
      end
    end
end
