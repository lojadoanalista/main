class Cloudwalk
  include Device::Helper

  WIFI_AUTHENTICATION_OPTIONS = {
    "None"         => Device::Network::AUTH_NONE_OPEN,
    "WEP"          => Device::Network::AUTH_NONE_WEP,
    "WEP Shared"   => Device::Network::AUTH_NONE_WEP_SHARED,
    "WPA PSK"      => Device::Network::AUTH_WPA_PSK,
    "WPA/WPA2 PSK" => Device::Network::AUTH_WPA_WPA2_PSK,
    "WPA2 PSK"     => Device::Network::AUTH_WPA2_PSK
  }

  WIFI_CIPHERS_OPTIONS = {
    "None"    => Device::Network::PARE_CIPHERS_NONE,
    "WEP 64"  => Device::Network::PARE_CIPHERS_WEP64,
    "WEP 128" => Device::Network::PARE_CIPHERS_WEP128,
    "CCMP"    => Device::Network::PARE_CIPHERS_CCMP,
    "TKIP"    => Device::Network::PARE_CIPHERS_TKIP
  }

  WIFI_MODE_OPTIONS = {
    "IBSS (Ad-hoc)" => Device::Network::MODE_IBSS,
    "Station (AP)"  => Device::Network::MODE_STATION
  }

  def self.boot
    if Device::Network.configured?
      if attach
        Device::Notification.start
      end
    end
  end

  def self.start
    if application = Device::ParamsDat.executable_app
      application.execute
    elsif Device::ParamsDat.apps.size > 1
      application = Device::ParamsDat.application_menu
      application.execute if application
    else
      self.wizard
    end
  end

  def self.wizard
    self.logical_number
    self.communication
    if Device::ParamsDat.update_apps
      Device::Notification.start
      Device::ParamsDat.application_menu.execute
    end
  end

  def self.logical_number
    number = Device::Setting.logical_number
    Device::Setting.logical_number = form("Logical Number (#{number}): ", 0, 4, number, true)
  end

  def self.communication
    configure = menu("Would like to configure communication?",
                     {"Yes" => true, "No" => false})
    if (configure)
      media = menu("Select Media:",
                   {"WIFI" => true, "GPRS" => false})
      if media
        Device::Setting.media = Device::Network::MEDIA_WIFI
        Device::Setting.authentication = menu("Authentication", WIFI_AUTHENTICATION_OPTIONS.merge(default: Device::Setting.authentication))
        Device::Setting.password       = form("Password", :min => 0, :max => 127, :default => Device::Setting.password)
        Device::Setting.essid          = form("Essid", :min => 0, :max => 127, :default => Device::Setting.essid)
        Device::Setting.channel        = form("Channel", :min => 0, :max => 127, :default => Device::Setting.channel)
        Device::Setting.cipher         = menu("Cipher", WIFI_CIPHERS_OPTIONS.merge(default: Device::Setting.cipher))
        Device::Setting.mode           = menu("Mode", WIFI_MODE_OPTIONS.merge(default: Device::Setting.mode))
      else
        Device::Setting.media    = Device::Network::MEDIA_GPRS
        Device::Setting.apn      = form("Apn", :min => 0, :max => 127, :default => Device::Setting.apn)
        Device::Setting.user     = form("User", :min => 0, :max => 127, :default => Device::Setting.user)
        Device::Setting.password = form("Password", :min => 0, :max => 127, :default => Device::Setting.password)
      end

      Device::Setting.network_configured = "1"
    end
  end

  def self.set_wifi_config
    #WIFI
    Device::Setting.media          = Device::Network::MEDIA_WIFI
    Device::Setting.mode           = Device::Network::MODE_STATION

    #Device::Setting.authentication = Device::Network::AUTH_WPA_WPA2_PSK
    #Device::Setting.cipher         = Device::Network::PARE_CIPHERS_CCMP
    #Device::Setting.password       = "desgracapelada"
    #Device::Setting.essid          = "Barril do Chaves"
    #Device::Setting.channel        = "0"

    # WIFI Office
    Device::Setting.authentication = Device::Network::AUTH_WPA_WPA2_PSK
    Device::Setting.cipher         = Device::Network::PARE_CIPHERS_TKIP
    Device::Setting.password       = "cloudwalksemfio"
    Device::Setting.essid          = "CloudWalk"
    Device::Setting.channel        = "0"

    #GPRS
    #Device::Setting.mode           = Network::MEDIA_GPRS
    #Device::Setting.logical_number = "1"
    #Device::Setting.apn            = "zap.vivo.com.br"
    #Device::Setting.user           = "vivo"
    #Device::Setting.pass           = "vivo"
    Device::Setting.network_configured = "1"
  end
end
