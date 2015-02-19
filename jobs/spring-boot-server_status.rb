require 'rest_client'
require 'json'

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '5s', :first_in => 0 do |job|

  begin
    response = RestClient.get 'http://localhost:8080/health'
    @data = JSON.parse response.body
    status = @data['status']
  rescue Errno::ECONNREFUSED
    status = 'DOWN'
  end

  send_event('status', {value: status})
end
