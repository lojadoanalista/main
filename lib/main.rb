require 'simplehttp'

class Main < Device
  def self.call
    super

    app_loop do
      Device::Display.clear
      Device::Display.print("CloudWalk", 1, 5)
      Device::Display.print("Serial #{Device::System.serial}", 2, 4)
      Device::Display.print(" 1 - Initialization", 5)

      CloudWalkInit.perform if getc == "1"
      # TIMEOUT GETC
      # FLOAT sleep
      # EXIT
    end
  end

  def self.version
    "0.0.1"
  end
end

