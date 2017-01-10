# Mac Bootstrap

Mac Bootstrap is Chef cookbook that provides basic Mac OSX desktop configuration.

# What it does

- Install Homebrew, Cask and ChefDK
- Set user defaults system settings
- Download and install neccessary software

## Usage

`cd mac_bootstrap`

Then, run

`./bootstrap.sh`

Or run only Chef cookbook

`chef-client -z -o mac_bootstrap`
