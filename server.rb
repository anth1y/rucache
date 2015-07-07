require 'socket'
class Storage
  attr_accessor :key_value_hash
  def initialize
    self.key_value_hash = {}
  end
  def get(key)
    key_value_hash[key]
  end
  def put(key,value)
    key_value_hash[key] = value
  end
end

class Server
  # method to start the server
  # method to listen for messages on what
  #
  attr_reader :sock
  def initialize
    init_listen

    @store = Storage.new
  end

  def init_listen
    addr = Socket.sockaddr_un('rucache.sock')
    @sock_recv = Socket.new(:UNIX, :DGRAM)
    @sock_recv.bind(addr)

  end

  def init_send
    return if @sock_send
    addr2 = Socket.sockaddr_un('rucache2.sock')
    @sock_send = Socket.new(:UNIX, :DGRAM)
    @sock_send.connect(addr2)
  end

  def start
    loop do
      message @sock_recv.recv(255)
    end
  end

  def message(command)
    result = @store.send *command.split(" ")
    p result
    init_send
    @sock_send.send(result, 0)
  end
end

server = Server.new
server.start
