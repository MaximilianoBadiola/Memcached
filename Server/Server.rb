require 'socket'
require './RequestController.rb'

requestController = RequestController.new()

puts "Starting the Server................... 127.0.0.1"
server = TCPServer.new("127.0.0.1", 1337)

loop do
  Thread.start(server.accept) do |client|

    #Get the Input from Client Side
    client.puts "!You've successfully connected to the server 127.0.0.1 \r"
    execute = true
    while execute 
      input = client.gets

      if input.include? "quit"
        execute = false
        client.puts "Connection closed by foreign host"
        client.close
      end

      if not input.include? "get"
        valueInput = client.gets
        input = input + " " + valueInput
      end

      input    = input.strip
      response = requestController.executeRequest(input)
      client.puts response +"\r"
    end
  end
end