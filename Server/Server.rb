require 'socket'
require './RequestController.rb'

requestController = RequestController.new()
#requestController.purgeExpiredKeys()


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
      else

        if input.include? "set" or input.include? "add" or input.include? "replace" or input.include? "append" or input.include? "prepend" or input.      include? "cas"
          
          valueInput = client.gets
          input = input + " " + valueInput
        end

        input = input.strip
        response = requestController.executeRequest(input)
        client.puts response +"\r"
      end
    end
  end
end