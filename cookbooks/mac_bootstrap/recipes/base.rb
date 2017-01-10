user = node["user"]

execute 'killall Finder' do
  action :nothing
end

execute 'killall SystemUIServer' do
  action :nothing
end

execute 'killall Dock' do
  action :nothing
end

mac_defaults 'Show all hidden files' do
  domain 'com.apple.finder'
  key 'AppleShowAllFiles'
  user user
  value 1
  notifies :run, 'execute[killall Finder]', :immediately
end

directory "/Users/#{user}/Screenshots" do
  owner user
end

mac_defaults 'Save screenshots into proper directory' do
  domain 'com.apple.screencapture'
  key 'location'
  user user
  value "/Users/#{user}/Screenshots"
  notifies :run, 'execute[killall SystemUIServer]'
end

mac_defaults 'Show POSIX full path in Finder title' do
  domain 'com.apple.finder'
  key '_FXShowPosixPathInTitle'
  user user
  value 1
  notifies :run, 'execute[killall Finder]', :immediately
end

mac_defaults 'Do not write .DS_Store to network storage' do
  domain 'com.apple.desktopservices'
  key 'DSDontWriteNetworkStores'
  user user
  value 1
  notifies :run, 'execute[killall Finder]', :immediately
end

mac_defaults 'Do not ask when external disk plugged for a Time Machine backup' do
  domain 'com.apple.TimeMachine'
  key 'DoNotOfferNewDisksForBackup'
  user user
  value 1
  notifies :run, 'execute[killall Finder]', :immediately
end

mac_defaults 'Set a fast key repeat' do
  domain 'NSGlobalDomain'
  key 'KeyRepeat'
  user user
  value 2
  notifies :run, 'execute[killall Finder]'
end

mac_defaults 'Set a fast keyboard initial key repeat' do
  domain 'NSGlobalDomain'
  key 'InitialKeyRepeat'
  user user
  value 15
  notifies :run, 'execute[killall Finder]'
end

mac_defaults 'Disable autospelling correction' do
  domain 'NSGlobalDomain'
  key 'NSAutomaticSpellingCorrectionEnabled'
  user user
  value 0
end

mac_defaults 'Remove the auto-hiding Dock delay' do
  domain 'com.apple.dock'
  key 'autohide-delay'
  user user
  value 0
  notifies :run, 'execute[killall Dock]'
end

mac_defaults 'Save screenshots as PNG' do
  domain 'com.apple.screencapture'
  key 'type'
  user user
  value 'png'
end

mac_defaults 'Disable play user interface sound effects' do
  domain 'com.apple.systemsound'
  key 'com.apple.sound.uiaudio.enabled'
  user user
  value 0
  notifies :run, 'execute[killall SystemUIServer]'
end

mac_defaults 'Disable play feedback when volume is changed' do
  domain 'com.apple.sound.beep'
  key 'feedback'
  user user
  value 0
  notifies :run, 'execute[killall SystemUIServer]'
end

