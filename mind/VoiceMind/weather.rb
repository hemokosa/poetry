require 'net/http'
require 'uri'
require 'json'
require 'date'

begin
  uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=130040')
  json = Net::HTTP.get(uri)
  result = JSON.parse(json)
  #puts result['forecasts']
rescue
  puts "Error of Network Comes As No Surprise.\n"
else
  result['forecasts'].each do |forecast|
    puts(forecast['telop'])
    if forecast['temperature']['min'] != nil
      @min = forecast['temperature']['min']['celsius'].to_i
      @max = forecast['temperature']['max']['celsius'].to_i
      puts(@min.to_s)
      puts(@max.to_s)
    end
  end
end
