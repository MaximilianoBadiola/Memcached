require './Request.rb'
require './MemTable.rb'
require './RequestType.rb'
require './ResponseType.rb'

class RequestController include RequestType
    
    @@memTable = MemTable.new()
    @@responseType  = ResponseType.new
    @@command = ""
    @@key     = ""
    @@flags   = ""
    @@exptime = ""
    @@bytes   = ""
    @@value   = ""
    @@unique_cas_key = ""

    def initialize()
        @@memTable = MemTable.new()
    end

    def executeRequest(request)

        restartVars()
        inputHandler(request)

        if not (@@bytes.empty? && @@value.empty?)
            @error = errorHandler(@@bytes, @@value)

            if not @error.empty?
                return @error
            end
        end

        @customCommand = @@command.upcase.strip
        @request = Request.new(@@command, @@key, @@flags, @@exptime, @@bytes, @@value, @@unique_cas_key)

        case @customCommand
            when RequestType::GET
                return @@memTable.get(@request)

            when RequestType::GETS
                return @@memTable.gets(@request)

            when RequestType::SET
                return @@memTable.set(@request)

            when RequestType::ADD
                return @@memTable.add(@request)
                
            when RequestType::REPLACE
                return @@memTable.replace(@request)

            when RequestType::APPEND
                return @@memTable.append(@request)

            when RequestType::PREPEND
                return @@memTable.prepend(@request)      
                
            when RequestType::CAS
                return @@memTable.cas(@request) 
            else
              return @@responseType.error
        end
    end

    def inputHandler(request)

        @arrayRequest = request.split(" ")

        if @arrayRequest.length() > 0

            case @arrayRequest.length() 
                when 2 #GET O GETS COMMANDS
                    @@command = @arrayRequest.at(0)
                    @@key     = @arrayRequest.at(1)
                when 6 #SET APPEND PREPEND ADD COMMANDS
                    @index = 0

                    for inputIndex in @arrayRequest
                       
                        case @index
                        when  0 
                            @@command = inputIndex
                        when  1 
                            @@key     = inputIndex
                        when  2 
                            @@flags   = inputIndex
                        when  3 
                            @@exptime = inputIndex
                        when  4 
                            @@bytes   = inputIndex
                        when  5
                            @@value   = inputIndex
                        end
                        @index +=1 
                    end

                when 7 # CAS COMMAND
                    @index = 0

                    for inputIndex in @arrayRequest
                       
                        case @index
                        when  0 
                            @@command = inputIndex
                        when  1 
                            @@key     = inputIndex
                        when  2 
                            @@flags   = inputIndex
                        when  3 
                            @@exptime = inputIndex
                        when  4 
                            @@bytes   = inputIndex
                        when  5
                            @@unique_cas_key = inputIndex
                        when  6
                            @@value   = inputIndex
                        end
                        @index +=1 
                    end
            end
        end
    end

    def errorHandler(bytes, value)

        if value.length() > bytes.to_i 
            return @@responseType.client_error
        else
            return ""
        end
    end

    def restartVars()
        @@command = ""
        @@key     = ""
        @@flags   = ""
        @@exptime = ""
        @@bytes   = ""
        @@value   = ""
        @@unique_cas_key = ""
    end
end