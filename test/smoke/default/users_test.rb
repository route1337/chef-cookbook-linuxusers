#
# Cookbook Name:: r1337-linux-users
# Spec:: users
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-linux-users::users

if os[:name] == 'ubuntu'

  # Check if the ruby-shadow packages was installed
  describe package('ruby-shadow') do
    it { should be_installed }
  end
end

if ['ubuntu', 'centos'].include?(os[:name])

  # Verify the groups we manage exist
  describe group('sysadmins') do
    it { should exist }
    its('gid') { should eq 1337 }
  end
  describe group('sysusers') do
    it { should exist }
    its('gid') { should eq 8737 }
  end
  describe group('svcaccounts') do
    it { should exist }
    its('gid') { should eq 7782 }
  end

  # Check settings on the root user
  describe user('root') do
    it { should exist }
    its('group') { should eq 'root' }
    its('home') { should eq '/root' }
  end
  describe file('/root/.ssh/authorized_keys') do # We have to do this since InSpec doesn't have "it { should have_authorized_key 'ssh-rsa blah blah blah' }"
    it { should exist }
    its('content') { should match /ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr\+kz4TjGYe7gHzIw\+niNltGEFHzD8\+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL\+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm\+R4LOzFUGaHqHDLKLX\+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key/ }
  end

  # Check settings on the various users we want deleted as they are not in the test data bag
  %w{billie karen jenna}.each do |user|
    # Verify the user is gone
    describe user(user) do
      it { should_not exist }
    end
    # Verify the user's home directory was cleaned
    describe file("/home/#{user}") do
      it { should_not exist }
    end
  end

  # Verify the test admin user was created correctly
  describe user('david') do
    it { should exist }
    its('groups') { should eq ['david', 'sysadmins'] }
    its('home') { should eq '/home/david' }
  end
  describe file('/home/david/.ssh/authorized_keys') do # We have to do this since InSpec doesn't have "it { should have_authorized_key 'ssh-rsa blah blah blah' }"
    it { should exist }
    its('content') { should match /ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr\+kz4TjGYe7gHzIw\+niNltGEFHzD8\+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL\+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm\+R4LOzFUGaHqHDLKLX\+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== david/ }
  end

  # Verify the test standard user was created correctly
  describe user('matt') do
    it { should exist }
    its('groups') { should eq ['matt', 'sysusers'] }
    its('home') { should eq '/home/matt' }
  end
  describe file('/home/matt/.ssh/authorized_keys') do # We have to do this since InSpec doesn't have "it { should have_authorized_key 'ssh-rsa blah blah blah' }"
    it { should exist }
    its('content') { should match /ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr\+kz4TjGYe7gHzIw\+niNltGEFHzD8\+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL\+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm\+R4LOzFUGaHqHDLKLX\+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== matt/ }
  end

  # Verify the test service user was created correctly
  describe user('peter') do
    it { should exist }
    its('groups') { should eq ['peter', 'svcaccounts'] }
    its('home') { should eq '/home/peter' }
  end
  describe file('/home/peter/.ssh/authorized_keys') do # We have to do this since InSpec doesn't have "it { should have_authorized_key 'ssh-rsa blah blah blah' }"
    it { should exist }
    its('content') { should match /ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr\+kz4TjGYe7gHzIw\+niNltGEFHzD8\+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL\+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm\+R4LOzFUGaHqHDLKLX\+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== peter/ }
  end

  # Verify sudoers has passwordless sudo for the sysadmins group
  describe file('/etc/sudoers') do
    its('content') { should match /%sysadmins ALL=\(ALL\) NOPASSWD:ALL/ }
  end
else
  # Do nothing
end