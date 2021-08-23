# Memcached
Memcached-Server developed on Ruby for moove-it cooding challenge

## Features
Memcached commands allowed 

Retrieval commands:

    - get
        retrieve the value stored at key. If the key does not exist in Memcached, then it returns nothing

    - gets
        retrieve the value stored at key with CAS token. If the key does not exist in Memcached, then it returns nothing

Storage commands:

    - set
        set command is used to set a new value to a new or existing key

    - add 
        add command is used to set a value to a new key. If the key already exists, then it gives the output NOT_STORED

    - replace
        replace command is used to replace the value of an existing key. If the key does not exist, then it gives the output NOT_STORED

    - append
        append command is used to add some data in an existing key. The data is stored after the existing data of the key.

    - prepend
        prepend command is used to add some data in an existing key. The data is stored before the existing data of the key

    - cas
        CAS command is used to set the data if it is not updated since last fetch. If the key does not exist in Memcached, then it returns NOT_FOUND

## Installation

You need Ruby 3.0.2.
You also need rspec gem for run test.

```bash
gem install rspec
```

## Usage

### Server
Start a local networked memcached server: open a new terminal on the project folder and run: ruby server.rb

### Client

This project was tested with Telnet in development instance, but you can use the client-server application that you prefer.

For windows users you should activate the telnet client from windows Programs and Features.
 (installation) [https://phoenixnap.com/kb/telnet-windows]

 ![alt text](https://github.com/MaximilianoBadiola/Memcached/blob/main/Img/TelnetExample.png?raw=true)
 

 Open a new terminal, with the server running execute "telnet 127.0.0.1 1337" to establish a connection with the memcached server.

 The terminal will display "!You've successfully connected to the server 127.0.0.1", if the server is not running the terminal will display "Connecting To 127.0.0.1...Could not open connection to the host, on port 1337: Connect failed"


 ## Sample Commands

#### set key flags exptime bytes  
#### value 

    set foo 0 3000 3 
    foo

#### get key

    get foo

#### gets key

    gets foo
    
#### cas key flags exptime bytes unique_cas_key
#### value

    cas foo 0 3000 4 1
    test 

#### append key flags exptime bytes
#### value

    append foo 0 3000 3
    bar

#### prepend key flag exptime bytes
#### value

    prepend foo 0 3000 3
    bar

## Test

Open a new terminal on the project folder and run: `rspec RequestController_spec.rb`

## Diagrams

#### Architectural diagram

Users will interact with mencached server through telnet, When a request arrives to the server, the server will  invoke a function in request controller.
Request controller will handle the inptus, validation errors and decide which MemTable's function will be executed
MemTable object execute the function called by the Controller, will validate the expiration time and purge if necesary. At the end, it will check if the value is stored in the hash and build a response. 
DB logic is not Included

 ![alt text](https://github.com/MaximilianoBadiola/Memcached/blob/main/Img/MemcachedArchDiagram.png?raw=true)


#### Class diagram

 ![alt text](https://github.com/MaximilianoBadiola/Memcached/blob/main/Img/MemcachedClassDiagram.png?raw=true)