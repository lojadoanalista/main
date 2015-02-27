require 'simplehttp'

class Main < Device
  include Device::Helper
  def self.call
    Cloudwalk.boot
    Device::Display.clear

    Device.app_loop do
      time = Time.now
      Device::Display.print_bitmap("./shared/walk.bmp",0,0)
      Device::Display.print("#{time.year}/#{time.month}/#{time.day}  #{time.hour}:#{time.min}:#{time.sec}", 6, 1)
      puts ""
      case getc(900)
      when Device::IO::ENTER
        Cloudwalk.start
      when Device::IO::F1
        AdminConfiguration.menu
      when Device::IO::CANCEL
        break
      end
    end
  end

  def self.version
    "0.0.1"
  end
end
