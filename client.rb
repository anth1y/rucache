#!/usr/bin/env ruby
## figure out how to use the put and get command in the client
require 'readline'
require 'socket'

class Client
  def initialize
    restart_socket
  end

  def restart_socket
    addr = Socket.sockaddr_un('rucache.sock')
    @sock_send = Socket.new(:UNIX, :DGRAM)
    @sock_send.connect(addr)

    addr2 = Socket.sockaddr_un('rucache2.sock')
    @sock_recv = Socket.new(:UNIX, :DGRAM)
    @sock_recv.bind(addr2)
  end


  def console
    while line = Readline.readline('> ',true)
      p line
      begin
        @sock_send.send(line, 0)
      p  @sock_recv.recv(255)
      rescue Errno::ECONNREFUSED => e
        restart_socket
        retry
      end
    end
  end
end

client = Client.new
client.console

