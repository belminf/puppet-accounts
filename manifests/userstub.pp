define accounts::userstub($uid, $fullname, $shell, $password, $groups, $managehome, $keytype='rsa', $pubkey=undef) {

    # Ensure managed user doesn't exist unless realized
    user { $name:
        ensure     => absent,
        uid        => $uid,
        comment    => $fullname,
        shell      => $shell,
        groups     => $groups,
        password   => $password,
        managehome => $managehome,
    }

    # If pubkey, ensure absent till realized
    if $pubkey {
        @ssh_authorized_key { "${name}-puppet-managed":
            ensure => present,
            user   => $name,
            type   => $keytype,
            key    => $pubkey,
        }
    }

    # Virtualized user to be realized
    @accounts::user { $name:
        groups => $groups,
    }
}
