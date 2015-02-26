require 'simplehttp'

class Main < Device
  def self.call
    Device::Display.clear
    Device::Display.print("CloudWalk", 2, 5)
    Device::Display.print("Serial #{Device::System.serial}", 3, 4)
    Device::Display.print(" 1 - Initialization", 5)

    Device.app_loop do
      time = Time.now
      Device::Display.print("#{time.year}/#{time.month}/#{time.day}  #{time.hour}:#{time.min}:#{time.sec}", 0, 0)
      puts ""
      case getc(900)
      when "1"
        Cloudwalk.perform
      when Device::IO::CANCEL
        break
      end
    end
  end

  def self.version
    "0.0.1"
  end
end

