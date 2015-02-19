require 'rest_client'
require 'json'

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '10s', :first_in => 0 do |job|

  response = RestClient.get 'http://localhost:8080/metrics'
  @data = JSON.parse response.body
  heap_used = @data['heap.used']/1000

  send_event('heap_used', {value: heap_used})
end
