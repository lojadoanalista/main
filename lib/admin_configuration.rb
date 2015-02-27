class AdminConfiguration
  include Device::Helper

  def self.menu
    Device::Display.clear
    Device::Display.print("Admin Configuration", 0, 0)
    Device::Display.print(" 1 - Wi-fi Config", 1, 0)
    Device::Display.print(" 2 - Update Apps", 2, 0)
    Device::Display.print(" 3 - Host", 3, 0)
    Device::Display.print(" 4 - Logical Number", 4, 0)
    key = getc
    if key == "1"
      Cloudwalk.communication
    elsif key == "2"
      Device::ParamsDat.update_apps
    elsif key == "3"
      Device::Display.clear
      Device::Display.print("Select:", 0, 7)
      Device::Display.print(" 1 - Production",1, 3)
      Device::Display.print(" 2 - Staging", 2, 3)

      if getc == "1"
        Device::Setting.host = "switch.cloudwalk.io"
      elsif getc == "2"
        Device::Setting.host = "switch-staging.cloudwalk.io"
      end
    elsif key == "4"
      Device::Display.clear
      Cloudwalk.logical_number
    end
  end
end
