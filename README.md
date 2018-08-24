Chef Cookbook - Linux Users
==============
This Chef cookbook will add/update/remove users and common groups on Linux systems

Changes Performed
------------
1. Configure local users and common groups according to contents of the data bag specified in the ['r1337-linux-users']['users_bag'] attribute

Requirements
------------
1. Chef (Tested on Chef 13.6.4)
2. Linux chef-clients (Tested on Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04, and CentOS 7.2 but kitchen will let you test anything you want)
3. The apt cookbook from Chef Supermarket
4. The users cookbook from Chef Supermarket
5. the line cookbook from Chef Supermarket
6. the zap cookbook from Chef Supermarket 

Installation Tips
------------

1. We personally use Berks to install this into Chef servers, because it will grab the dependencies for you as well.
2. You must set the attribute ['r1337-linux-users']['users_bag'] in your environment so it points at the correct data bag.
    1. We recommend setting this attribute at an environment or role level depending on what makes sense for your organization.

Limitations
------------
1. None so far :)

Known Issues
------------
1. None so far :)

users Data Bag Format
------------

    {
        "id": "david",
        "password": "$6$example2$xc7NaKOwWWOBoGdSOP.mUgy21MNMjmdHsRuiVAmoMLpQ0tr42xPxWhOWNCPvCClV8lpE3zKr8.TowR0ARoi3a1",
        "ssh_keys": [
          "ssh-rsa AAAAB3NzaC1yc2EAAAAD blah blah",
          "ssh-rsa AAAAB3NzaC1yc2EAAAAD blah blah"
        ],
        "groups": [ "sysadmins" ],
        "shell": "\/bin\/bash",
        "comment": "David"
    }

Use Cases
------------
Used to manage user deployment, key/permissions enforcement, and removal on Linux systems from a central repository.

Donate To Support This Chef Cookbook
------------
Route 1337, LLC operates entirely on donations. If you find this cookbook useful, please consider donating via one of these methods.

1. Bitcoin: 1CnzzrPh3iirEkLRLiWFKXDV9i5TXHQjE2
2. Bitcoin Cash: qzcq645swgd87s7t5mmmjcumf4armhtjt5euww5c29
3. Litecoin: LWYbc9hf5ErJsF874Q3wwmMiASHRWgwrjR
4. Ethereum: 0x117543aa7a4D704849171cA06568Ece71B111D18

Thank you for your support!
