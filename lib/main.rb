require 'simplehttp'

class Main < Device
  include Device::Helper
  def self.call
    Cloudwalk.boot
    Device::Display.clear

    Device.app_loop do
      time = Time.now
      if !File.exists("app_name")
        # Manual use of the main app
        Device::Display.print_bitmap("./shared/walk.bmp",0,0)
        Device::Display.print("#{time.month}/#{time.day}/#{time.year}  #{time.hour}:#{time.min}:#{time.sec}", 6, 1)
        puts ""
        case getc(900)
        when Device::IO::ENTER
          Cloudwalk.start
        when Device::IO::F1
          AdminConfiguration.get_password
        when Device::IO::F2
          break
        end
      else
        # TODO: We also need a way to retrieve the logical number
        file = File.open("app_name", "r")
        app  = file.read
        p "APP:#{app}"
        # Let's goo straight to the given app
        self.logical_number
        self.communication
        if Device::ParamsDat.update_apps
          Device::Notification.start
          Device::ParamsDat.executable_apps.each { |_app| p "APP: #{_app}" }
        end
      end
    end
  end

  def self.version
    "0.1.0"
  end
end
