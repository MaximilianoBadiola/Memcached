require 'date'

class Request

    def initialize(command, key, flags = 0, exptime = 0, bytes = 0, value = "", unique_cas_key = 0)
        @command            = command
        @key                = key
        @flags              = flags
        @exptime            = exptime
        @bytes              = bytes
        @value              = value
        @unique_cas_key     = unique_cas_key
        @current_datetime   = DateTime.now
    end

    def command 
        return @command
    end

    def key 
        return @key
    end

    def flags
        return @flags
    end

    def exptime
        return @exptime
    end

    def bytes
        return @bytes
    end

    def bytes=(bytes)
        @bytes = bytes
    end

    def value
        return @value
    end

    def value=(value)
        @value = value
    end

    def unique_cas_key
        return @unique_cas_key
    end

    def unique_cas_key=(unique_cas_key)
        @unique_cas_key = unique_cas_key
    end

    def current_datetime
        return @current_datetime
    end
end

