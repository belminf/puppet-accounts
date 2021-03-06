# Creates all groups by default and userstubs

class accounts(
    $default_shell='/bin/bash',
    $default_password='*',
    $present_managehome=true,
    $absent_managehome=false,
    $membership='minimum',
    $home=undef,
) {

    $user_defaults = {
        shell              => $default_shell,
        password_hash      => $default_password,
        present_managehome => $present_managehome,
        absent_managehome  => $absent_managehome,
        membership         => $membership,
        groups             => undef,
        home               => undef,
    }

    # Create all users virtually
    create_resources('accounts::userstub', hiera_hash('users'), $user_defaults)

    # Create groups
    create_resources('accounts::group', hiera_hash('groups'))
}
