# This file is automatically generated. Do not edit.

if Object.const_defined?('TestFlight') and !UIDevice.currentDevice.model.include?('Simulator')
  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationDidBecomeActiveNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
  TestFlight.takeOff('53064711be18b705102907eb06705516_MTExOTM5MjAxMi0wNy0xOSAwMTo1OTo0MC45Mzg0Njg')
  end)
end
