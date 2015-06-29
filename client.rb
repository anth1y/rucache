#!/usr/bin/env ruby
## figure out how to use the put and get command in the client
require 'readline'
require 'socket'

class Client
  def initialize
    @sock = Socket.new(:UNIX, :DGRAM)
    sock_srv = Socket.sockaddr_un('rucache.sock')
    @sock.connect(sock_srv)
  end


  def console
    while line = Readline.readline('> ',true)
      p line
    end
  end
end

client = Client.new
client.console

