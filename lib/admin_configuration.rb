class AdminConfiguration
  include Device::Helper

  def self.menu
    Device::Display.clear
    Device::Display.print("Configuration Menu", 0, 0)
    Device::Display.print(" 1 - Communication", 1, 0)
    Device::Display.print(" 2 - Update Apps", 2, 0)
    Device::Display.print(" 3 - Logical Number", 3, 0)
    Device::Display.print(" 4 - Set Clock", 4, 0)
    key = getc
    if key == "1"
      Cloudwalk.communication
    elsif key == "2"
      Device::ParamsDat.update_apps
    elsif key == Device::IO::F2
      puts ""
      keys = Device::IO.get_format(1, 6, options = {:mode => :secret})
      if keys == "999999"
        Device::Display.clear
        Device::Display.print("Select:", 0, 7)
        Device::Display.print(" 1 - Production",1, 3)
        Device::Display.print(" 2 - Staging", 2, 3)

        if getc == "1"
            Device::Setting.environment = "production"
            closing
            Device::System.restart
        elsif getc == "2"
          Device::Setting.environment = "staging"
          closing
          Device::System.restart
        end
      else
        menu
      end
    elsif key == "3"
      Device::Display.clear
      Cloudwalk.logical_number
    elsif key == "4"
      Device::Display.clear
      Device::Display.print("Input the year:",0,0)
      year = Device::IO.get_format(1, 4, option  = {:mode => :numbers})
      Device::Display.print("Input the month:",1,0)
      month = Device::IO.get_format(1, 2, option  = {:mode => :numbers})
      Device::Display.print("Input the day:",2,0)
      day = Device::IO.get_format(1, 2, option  = {:mode => :numbers})
      Device::Display.print("Input the hour:",3,0)
      h = Device::IO.get_format(1, 2, option  = {:mode => :numbers})
      Device::Display.print("Input the minute:",4,0)
      m = Device::IO.get_format(1, 2, option  = {:mode => :numbers})
      Device::Display.print("Input the second:",5,0)
      s = Device::IO.get_format(1, 2, option  = {:mode => :numbers})
      time = Time.new(year,month,day,h,m,s)
      time.hwclock
    end
  end

  def self.closing
    Device::Display.clear
    i = 1
    loop do
      Device::Display.print("Rebooting...",3,3)
      Device::Display.print("#{i}")
      sleep(1)
      i += 1
      break if i > 3
    end
  end
end
