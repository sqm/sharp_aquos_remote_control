require 'spec_helper'

describe SharpAquosRemoteControl do

  before do
    @command = nil
    @television = TCPServer.new 1337
    Thread.new {
      request = @television.accept
      @command = request.recvmsg.first
      request.close
    }
  end

  after do
    @television.close
  end

  let (:remote) { SharpAquosRemoteControl.new(IPSocket.getaddress(Socket.gethostname), 1337) }

  describe '#on' do
    it "should send the `Power On` control" do
      remote.on
      expect(@command).to eq("POWR1   \x0D")
    end
  end

end
