#
# Cookbook Name:: r1337-linux-users
# Recipe:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe will call the other recipes in this cookbook based on the detected system

case node['platform']
when 'ubuntu', 'centos'
  include_recipe 'r1337-linux-users::users' # Configure the Linux users and common groups on the system
else
  # Do nothing
end
