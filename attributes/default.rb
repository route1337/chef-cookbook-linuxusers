#
# Cookbook Name:: r1337-linux-users
# Attribute:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This attribute determines the data bag used for users. That way PROD and DEV can have separate admins
default['r1337-linux-users']['users_bag'] = 'linuxusers'
