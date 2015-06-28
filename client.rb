#!/usr/bin/env ruby
## figure out how to use the put and get command in the client
require 'socket'
class Client
  def initialize
    @sock = Socket.new(:UNIX, :DGRAM)
    sock_srv = Socket.sockaddr_un('rucache.sock')
    @sock.connect(sock_srv)
  end


  def wire
    loop do
      @sock.send
    end
  end
end

client = Client.new
client.wire

