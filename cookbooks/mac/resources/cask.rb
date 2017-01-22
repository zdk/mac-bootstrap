resource_name :cask

action :install do
  execute "brew cask install #{name}"
end
