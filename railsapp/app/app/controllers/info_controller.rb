class InfoController < ApplicationController
  require 'socket'
  $hitcount = 0
  $hostname = Socket.gethostname
  $local_ip = Socket.gethostbyname($hostname)
  $start_time = Time.now.strftime('%Y/%m/%d %H:%M:%S')
  def index
  end

  def json
    $hitcount += 1
    render json: {
                  "Start Time" => "#{$start_time}",
                  "Hostname" => "#{$hostname}",
                  "Local Address" => "#{$local_ip}",
                  "Remote Address" => "#{request.remote_ip}",
                  "Hit Count" => "#{$hitcount}"
                 }
  end
end
