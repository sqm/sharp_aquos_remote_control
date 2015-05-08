require 'socket'

class SharpAquosRemoteControl
  attr_reader :hostname
  attr_reader :port
  attr_reader :username
  attr_reader :password

  def initialize(hostname = "192.168.2.188", port = 10002, username = nil, password = nil)
    @hostname = hostname
    @port = port
    @username = username
    @password = password
  end

  def analog_channel(value)
    return "Analog Channels are limited to 2 through 69" if value < 2 || value > 69
    new_channel = value.to_s.rjust(2, "0")

    request "DCCH" + new_channel + "  \x0D"
  end

  def digital_channel(value)
    first = (value.to_s.split(".")[0]).to_i
    second = (value.to_s.split(".")[1] || 0).to_i
    return "Analog Channels are limited to 1 through 99.99" if first < 1 || first > 99 || second < 0 || second > 99
    new_channel = first.to_s.rjust(2, "0") + second.to_s.rjust(2, "0")

    request "DA2P" + new_channel + "\x0D"
  end

  def channel_down
    request "CHUP0   \x0D"
  end

  def channel_up
    request "CHUP0   \x0D"
  end

  def input(value)
    return "Inputs are limited to 1 through 9" if value < 1 || value > 9
    request("IAVD" + value.to_s + "   \x0D")
  end

  def input?
    request "IAVD?   \x0D"
  end

  def mute
    request "MUTE1   \x0D"
  end

  def unmute
    request "MUTE2   \x0D"
  end

  def muted?
    request("MUTE?   \x0D") == "1"
  end

  def off
    request "POWR0   \x0D"
  end

  def off?
    request("POWR?   \x0D") == "0"
  end

  def on
    request "POWR1   \x0D"
  end

  def on?
    request("POWR?   \x0D") == "1"
  end

  def volume(level)
    return "Volume is limited to 0 through 60" if level < 0 || level > 60
    new_volume = level.to_s.rjust(2, "0")

    request("VOLM" + new_volume + "  \x0D")
  end

  def volume?
    request("VOLM?   \x0D").to_i
  end

  def request(command)
    response = Socket.tcp(@hostname, @port) do |socket|
      socket.write command
      socket.recv 1024
    end

    response.strip
  end
end
