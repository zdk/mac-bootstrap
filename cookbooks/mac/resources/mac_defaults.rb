resource_name :mac_defaults

property :description, name_property: true
property :domain,      String, identity: true
property :user,        String, identity: true, default: 'root'

property :key,         String, identity: true
property :value,       [String, Integer, Float, true, false]

def user_read(v)
  ((float = Float(v)) && (float % 1.0 == 0) ? float.to_i : float)
rescue ArgumentError
  v
end

load_current_value do
  defaults = `sudo -u #{user} defaults read \"#{domain}\" \"#{key}\"`.chomp
  value user_read(defaults)
end

action :write do
  converge_if_changed do
    execute "sudo -u #{user} defaults write \"#{domain}\" \"#{key}\" #{value}"
  end
end
