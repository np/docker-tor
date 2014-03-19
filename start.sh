#!/bin/bash

set -eu

# Generate a random nickname for the relay
NICKNAME=${NICKNAME:-xndocker$(head -c 16 /dev/random | sha1sum | cut -c1-10)}

cat >/var/lib/tor/torrc <<TORRC
Log notice  stderr
ExitPolicy  reject *:*
ORPort      9001
DirPort     9030
SOCKSPort   0
Nickname    $NICKNAME
ContactInfo $CONTACT_INFO
TORRC

exec tor -f /var/lib/tor/torrc
