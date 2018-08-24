#
# Cookbook Name:: r1337-linux-users
# Recipe:: users
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe will configure the correct Linux users and common groups according to the data bag specified in the ['r1337-linux-users']['users_bag'] attribute

# Handle some Ubuntu specific requirements before managing users
case node['platform']
when 'ubuntu'
  # Make sure apt repo is refreshed
  include_recipe 'apt'

  # Install ruby-shadow so Chef can manage the shadow file
  package 'ruby-shadow' do
    action :install
  end
else
  # Do nothing
end

case node['platform']
when 'ubuntu', 'centos'
  # Do stuff here soon
else
  # Do nothing
end

# If in Kitchen we will create a few test users via command line so they are not considered "managed"
# This way we can test if they get removed properly in testing
if ENV['TEST_KITCHEN'] # Check if running Kitchen
  # Get the correct path for useradd
  case node['platform']
  when 'ubuntu'
    useradd_path = '/usr/sbin/useradd'
  when 'centos'
    useradd_path = '/sbin/useradd'
  else
    useradd_path = '/sbin/useradd' # Just assume the RHEL variant for all other systems
  end

  # Create a few fake test users
  %w{billie karen jenna}.each do |users|
    execute "Adding test user #{users}" do
      command "#{useradd_path} -m #{users} -s /bin/bash -d /home/#{users}"
    end
  end
else
  # Do nothing
end

# Adding and updating users
case node['platform']
when 'ubuntu', 'centos'
  # This will use the users cookbook to manage all users in the "linuxusers" data bag that are in the "root" group
  # This should only be the user root
  users_manage 'root' do
    data_bag node['r1337-linux-users']['users_bag']
    group_name 'root'
    action :create
  end

  # Manage users in the sysusers group (non-admins)
  users_manage 'sysusers' do
    group_id 8737
    action :create
    data_bag node['r1337-linux-users']['users_bag']
  end

  # Manage users in the sysadmins group (sudoers)
  users_manage 'sysadmins' do
    group_id 1337
    action :create
    data_bag node['r1337-linux-users']['users_bag']
  end

  # Manage users in the svcaccounts group (non-admin users used by services)
  users_manage 'svcaccounts' do
    group_id 7782
    action :create
    data_bag node['r1337-linux-users']['users_bag']
  end

  # Make sure sysadmins have passwordless sudo
  replace_or_add 'passwordless sudo for sysadmins' do
    path '/etc/sudoers'
    pattern '^%sysadmins'
    line '%sysadmins ALL=(ALL) NOPASSWD:ALL'
  end

  # Set our users data bag entries as the keep list for zap
  node.override['zap']['users']['keep'] = data_bag(node['r1337-linux-users']['users_bag'])
  # Protect the nobody user since it usually has a high uid and is required for proper system functionality
  node.override['zap']['users']['keep'] += [ 'nobody']

  # If in Kitchen we will need to protect a few additional users in order to avoid breaking the vm
  if ENV['TEST_KITCHEN'] # Check if running Kitchen
    node.override['zap']['users']['keep'] += ['vagrant', 'vboxadd']
  end

  # Zap all local users not exempt from keep but with a UID >= 1000
  zap_users '/etc/passwd' do
    # Filter on users with a UID >= 1000
    filter { |u| u.uid >= 1000 }
    notifies :run, 'execute[cleanupremoveduserdirs]', :immediately
  end

  # Scan /home for directories with invalid owners
  # THIS IS A HACK WE ARE DOING UNTIL ZAP SUPPORTS USER DIR CLEANUPS
  execute 'cleanupremoveduserdirs' do
    command 'find /home/ -maxdepth 1 -nouser | xargs rm -rf'
    action :nothing # We do this to force this to run last via the below ruby block
  end
  ruby_block 'cleanuoremoveduserdirslast' do
    block do
      true
    end
    notifies :run, 'execute[cleanupremoveduserdirs]', :delayed
  end
else
  # Do nothing
end
