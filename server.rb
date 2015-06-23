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
  def initialize
    @sock = Socket.new(:UNIX, :DGRAM)
    addr = Socket.sockaddr_un('rucache.sock')
    @sock.bind(addr)
    @store = Storage.new
  end

  def start
    loop do
      message @sock.recv(5)
    end
  end

  def message(command)
    @store.send *command.split("\t")
  end
end

server = Server.new
server.start
