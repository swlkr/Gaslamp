$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-testflight'

Motion::Project::App.setup do |app|

  # testflight
  app.development do
    app.testflight.sdk = 'vendor/TestFlightSDK'
    app.testflight.api_token = 'f1dd149b4624d0ddab9cd36c314cf39d_NTQwNjkzMjAxMi0wNy0xOSAwMTo1NTo0Mi41ODA0NzA'
    app.testflight.team_token = '53064711be18b705102907eb06705516_MTExOTM5MjAxMi0wNy0xOSAwMTo1OTo0MC45Mzg0Njg'
  end

  app.version = '2.0'
  app.short_version = '2'
  app.name = 'Gaslamp'
  app.identifier = 'com.swlkr.gaslamp'
  app.release do
    app.provisioning_profile = "/Users/seanwalker/Library/MobileDevice/Provisioning Profiles/Gaslamp.mobileprovision"
  end
  app.interface_orientations = [:portrait]
  app.device_family = :iphone
  app.icons += ["Icon-72.png", "Icon.png", "Icon@2x.png", "Icon-Small-50.png", "Icon-Small.png", "Icon-Small@2x.png", "iTunesArtwork.png"]
  app.frameworks += ["AVFoundation"]

end
