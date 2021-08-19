
class ResponseType
    
    def stored
        return "STORED"
    end

    def not_stored
        return "NOT_STORED"
    end

    def end_response
        return "END"
    end

    def error
        return "ERROR"
    end

    def exist
        return "EXIST"
    end

    def not_found
        return "NOT_FOUND"
    end

    def client_error
        return "CLIENT_ERROR bad data chunk"
    end
end
