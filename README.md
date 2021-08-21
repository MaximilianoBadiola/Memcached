# Memcached
Memcached-Server developed on Ruby for moove-it cooding challenge

## Features
Memcached commands allowed 

Retrieval commands:

    - get
    - gets

Storage commands:

    - set
    - add
    - replace
    - append
    - prepend
    - cas

## Installation

You need Ruby 3.0.2.
You also need rspec gem for run test.

```bash
install the gem: gem install rspec
```

## Usage

### Server
Start a local networked memcached server: open a new terminal on the project folder and run: ruby server.rb

### Client

This project was tested with Telnet in development instance, but you can use the client-server application that you prefer.

For windows users you should activate the telnet client from windows Programs and Features.
 [installation] (https://phoenixnap.com/kb/telnet-windows)

 ![alt text](https://github.com/MaximilianoBadiola/Memcached/blob/main/Img/TelnetExample.png?raw=true)
 

 Open a new terminal, with the server running execute "telnet 127.0.0.1 1337" to establish a connection with the memcached server.

 The terminal will display "!You've successfully connected to the server 127.0.0.1", if the server is not running the terminal will display "Connecting To 127.0.0.1...Could not open connection to the host, on port 1337: Connect failed"


 ## Sample Commands

### set key flags exptime bytes  
### value 

    set foo 0 3000 3 
    foo

### get key

    get foo

### gets key

    gets foo
    
### cas key flags exptime bytes unique_cas_key
### value

    cas foo 0 3000 4 1
    test 

### append key flags exptime bytes
### value

    append foo 0 3000 3
    bar

### prepend key flag exptime bytes
### value

    prepend foo 0 3000 3
    bar

## Test

Open a new terminal on the project folder and run: rspec RequestController_spec.rb

## Diagrams

### Architectural diagram

 ![alt text](https://github.com/MaximilianoBadiola/Memcached/blob/main/Img/MemcachedArchDiagram.png?raw=true)


### Class diagram

 ![alt text](https://github.com/MaximilianoBadiola/Memcached/blob/main/Img/MemcachedClassDiagram.png?raw=true)