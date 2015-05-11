require 'simplehttp'

class Main < Device
  include Device::Helper
  def self.call
    Cloudwalk.boot
    Device::Display.clear

    Device.app_loop do
      time = Time.now
      if !File.exist?("app_name")
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
        app_name  = file.read
        # Let's goo straight to the given app
        # IMPORTANT: We've been using 1410 to test these apps, but the
        # emulator is intended to work with the logical number `emulator`
        Cloudwalk.logical_number("emulator")
        Device::ParamsDat.download
        extracted_app = nil
        Device::ParamsDat.apps.each_with_index do |app, index|
          if app != nil && app.file_path.include?(app_name)
            extracted_app = app
            Device::ParamsDat.apps.delete_at(index)
          end
        end
        if Device::ParamsDat.update_apps
          Device::Notification.start
          mrb_eval "Context.start('#{app_name}', '#{Device.adapter}')"
        end
      end
    end
  end

  def self.version
    "0.1.0"
  end
end
