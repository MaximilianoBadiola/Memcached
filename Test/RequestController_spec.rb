require '../Server/RequestController.rb'
require '../Server/Request.rb'
require '../Server/MemTable.rb'
require '../Server/RequestType.rb'
require '../Server/ResponseType.rb'

describe RequestController do
    requestController = RequestController.new

    it 'set ok' do
        input = "set foo 0 3000 3 foo"
        response = requestController.executeRequest(input)
        expect(response).to eq('STORED') 
    end

    it 'set error' do
        input = "set foo 0 3000 2 foo"
        response = requestController.executeRequest(input)
        expect(response).to eq('CLIENT_ERROR bad data chunk') 
    end

    it 'get ok' do
        input = "get foo"
        response = requestController.executeRequest(input)
        expect(response).to eq('foo 0 3' +"\r\n" + 'END') 
    end

    it 'get error' do
        input = "get bar"
        response = requestController.executeRequest(input)
        expect(response).to eq('END') 
    end

    it 'append ok' do
        input = "append foo 0 3000 3 bar"
        response = requestController.executeRequest(input)
        expect(response).to eq('STORED') 
    end

    it 'append error' do
        input = "append foo 0 3000 2 foo"
        response = requestController.executeRequest(input)
        expect(response).to eq('CLIENT_ERROR bad data chunk') 
    end

    it 'prepend ok' do
        input = "append foo 0 3000 3 bar"
        response = requestController.executeRequest(input)
        expect(response).to eq('STORED') 
    end

    it 'prepend error' do
        input = "append foo 0 3000 2 foo"
        response = requestController.executeRequest(input)
        expect(response).to eq('CLIENT_ERROR bad data chunk') 
    end

    it 'replace ok' do
        input = "replace foo 0 3000 4 test"
        response = requestController.executeRequest(input)
        expect(response).to eq('STORED') 
    end

    it 'replace error' do
        input = "replace foo 0 3000 2 test"
        response = requestController.executeRequest(input)
        expect(response).to eq('CLIENT_ERROR bad data chunk')  
    end

    it 'add ok' do
        input = "add moo 0 3000 3 moo"
        response = requestController.executeRequest(input)
        expect(response).to eq('STORED') 
    end

    it 'add error' do
        input = "add moo 0 3000 3 moo"
        response = requestController.executeRequest(input)
        expect(response).to eq('NOT_STORED') 
    end

    it 'gets ok' do
        input = "gets moo"
        response = requestController.executeRequest(input)
        expect(response).to eq('moo 0 3 1' +"\r\n" + 'END') 
    end

    it 'gets error' do
        input = "gets po"
        response = requestController.executeRequest(input)
        expect(response).to eq('END') 
    end

    it 'cas ok' do
        input = "cas moo 0 3000 4 1 moov"
        response = requestController.executeRequest(input)
        expect(response).to eq('STORED') 
    end

    it 'cas not_found' do
        input = "cas it 0 3000 4 10 moov"
        response = requestController.executeRequest(input)
        expect(response).to eq('NOT_FOUND') 
    end

    it 'cas exist' do
        input = "cas moo 0 3000 4 10 moov"
        response = requestController.executeRequest(input)
        expect(response).to eq('EXIST') 
    end

    it 'purge key' do
        input = "set moov 0 5 7 moov-it"
        response = requestController.executeRequest(input)
        if response  == 'STORED'
            input = "get moov"
            response = requestController.executeRequest(input)
            if response.include? ('moov-it')
                sleep(6)
                input = "get moov"
                response = requestController.executeRequest(input)
            end
        end
        expect(response).to eq('END') 
    end
    
end
