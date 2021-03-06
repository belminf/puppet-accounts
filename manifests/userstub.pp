# Stub for the user. Will ensure absent unless overwritten by account::user

define accounts::userstub(
    $uid,
    $fullname,
    $shell,
    $password_hash,
    $groups,
    $membership,
    $absent_managehome,
    $present_managehome,
    $keytype='rsa',
    $pubkey=undef,
    $home=undef,
) {

    # Ensure managed user doesn't exist unless realized
    user { $name:
        ensure     => absent,
        uid        => $uid,
        comment    => $fullname,
        shell      => $shell,
        groups     => $groups,
        password   => $password_hash,
        managehome => $absent_managehome,
        membership => $membership,
        home       => $home,
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
        groups     => $groups,
        managehome => $present_managehome,
    }
}
