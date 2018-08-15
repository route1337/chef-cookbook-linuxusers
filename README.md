Chef Cookbook - r1337-linux-users
==============
This Chef cookbook will

Changes Performed
------------
1. List of
2. Changes

Requirements
------------
1. Chef (Tested on Chef 13.6.4)
2. Linux chef-clients (Tested on Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04, and CentOS 7.2 but kitchen will let you test anything you want)

Installation Tips
------------

1. We personally use Berks to install this into Chef servers, because it will grab the dependencies for you as well.

Limitations
------------
1. None so far :)

Known Issues
------------
1. None so far :)

some_data_bag Data Bag Format
------------

    {
        "id": "root",
        "home": "/root",
        "password": "$6$example2$xc7NaKOwWWOBoGdSOP.mUgy21MNMjmdHsRuiVAmoMLpQ0tr42xPxWhOWNCPvCClV8lpE3zKr8.TowR0ARoi3a1",
        "ssh_keys": [
          "ssh-rsa AAAAB3NzaC1yc2EAAAAD blah blah",
          "ssh-rsa AAAAB3NzaC1yc2EAAAAD blah blah"
        ],
        "groups": [ "root" ],
        "uid": 0 ,
        "shell": "\/bin\/bash",
        "comment": "root"
    }

Use Cases
------------
USE CASES

Donate To Support This Chef Cookbook
------------
Route 1337, LLC operates entirely on donations. If you find this cookbook useful, please consider donating via one of these methods.

1. Bitcoin: 1CnzzrPh3iirEkLRLiWFKXDV9i5TXHQjE2
2. Bitcoin Cash: qzcq645swgd87s7t5mmmjcumf4armhtjt5euww5c29
3. Litecoin: LWYbc9hf5ErJsF874Q3wwmMiASHRWgwrjR
4. Ethereum: 0x117543aa7a4D704849171cA06568Ece71B111D18

Thank you for your support!

