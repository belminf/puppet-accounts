#puppet-accounts

Group-based management of accounts.

Since I'm using directory authentication (kerberos in my case), it's tailored for that use-case.

To include groups in a node:

    class { 'accounts': }
    Accounts::Usergroup <| title == sysadmins |>

Using hiera data (users and groups).
