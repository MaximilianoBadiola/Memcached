require_relative './Request.rb'
require_relative './ResponseType.rb'
require 'date'

class MemTable

    @@responseType  = ResponseType.new
    @@hashTable     = Hash.new

    def table 
        return @@hashTable
    end

    def get(request)
        keyRequest = request.key.downcase.strip
        if validateKey(keyRequest)
            if not @@hashTable[keyRequest].nil?
                storedRequest = @@hashTable[keyRequest] 
                @response = storedRequest.value.to_s + " " + storedRequest.flags.to_s + " " + storedRequest.bytes.to_s
                return @response +"\r\n" + @@responseType.end_response
            else
                return @@responseType.end_response
            end
        else
            return @@responseType.end_response
        end
    end

    def gets(request)
        keyRequest = request.key.downcase.strip
        if validateKey(keyRequest)
            if @@hashTable[keyRequest].nil?
                return @@responseType.end_response
            else
                storedRequest = @@hashTable[keyRequest] 
                @response = storedRequest.value.to_s + " " + storedRequest.flags.to_s + " " + storedRequest.bytes.to_s + " " + storedRequest.unique_cas_key.to_s
                return @response +"\r\n" + @@responseType.end_response
            end
        else
            return @@responseType.end_response
        end
    end

    def set(request)
        keyRequest = request.key.downcase.strip
        @casValue = getCASValue(keyRequest)
        request.unique_cas_key =  @casValue
        @@hashTable.store(keyRequest, request)
        return @@responseType.stored
    end

    def add(request)
        keyRequest = request.key.downcase.strip
        if  @@hashTable[keyRequest].nil?
            set(request)
        else
            return @@responseType.not_stored
        end
    end
    
    def replace(request)
        keyRequest = request.key.downcase.strip
        if  @@hashTable[keyRequest].nil?
            return @@responseType.not_stored
        else
            set(request)
        end
    end

    def append(request)
        keyRequest = request.key.downcase.strip

        if not @@hashTable[keyRequest].nil?
            storedRequest = @@hashTable[keyRequest] 
            casValue = getCASValue(keyRequest)
            storedRequest.unique_cas_key = casValue
            storedRequest.bytes = storedRequest.bytes.to_i + request.bytes.to_i
            storedRequest.value = storedRequest.value + request.value 
            @@hashTable.store(keyRequest, storedRequest)
            return @@responseType.stored
        else
            return @@responseType.not_stored
        end
    end

    def prepend(request)
        keyRequest = request.key.downcase.strip

        if not @@hashTable[keyRequest].nil?
            storedRequest = @@hashTable[keyRequest] 
            casValue = getCASValue(keyRequest)
            storedRequest.unique_cas_key = casValue
            storedRequest.bytes = storedRequest.bytes.to_i + request.bytes.to_i
            storedRequest.value = request.value  + storedRequest.value
            @@hashTable.store(keyRequest, storedRequest)
            return @@responseType.stored
        else
            return @@responseType.not_stored
        end
    end

    def cas(request)
        keyRequest = request.key.downcase.strip
        if not @@hashTable[keyRequest].nil?
            storedRequest   = @@hashTable[keyRequest]
            @casStoredValue = storedRequest.unique_cas_key

            if @casStoredValue.to_s.strip == request.unique_cas_key.to_s.strip
                set(request)
            else
                return @@responseType.exist
            end
        else
            return @@responseType.not_found
        end
    end

    def getCASValue(keyRequest)
        
        if not @@hashTable[keyRequest].nil?
            storedRequest = @@hashTable[keyRequest] 
            value = storedRequest.unique_cas_key + 1
            return value
        else
            return 1
        end
    end

    def validateKey(keyRequest)
        if not @@hashTable[keyRequest].nil?
            storedRequest = @@hashTable[keyRequest]
            return purgeKey(storedRequest)
        else
            return false
        end
    end

    def purgeKey(request)
        keyRequest  = request.key.downcase.strip
        timeDiff    = ((DateTime.now - request.current_datetime) * 24 * 60 * 60).to_i
        if timeDiff.to_i > request.exptime.to_i
            @@hashTable.delete(keyRequest)
            return false
        else
            return true
        end
    end
end



