#!/bin/bash

if [ "$1"X = "set"X  ]
then
echo rrrrrrrrrrrr
fi

#exit 0


set_proxy_auth() {
# HTTP Proxy host
# port
# Use same
#Use authentication
# Enter username
# Enter password
# All of them
# password for gavin
./main.sh << EOF
set
lps5.sgp.st.com
80
y
y
bob wang
waxife%40123
1
sleep 1
0
EOF

git config --global core.gitProxy "/home/gavin/work/env/gitproxy"

}

unset_proxy() {
./main.sh << EOF
unset
1
0
EOF
git config --global --unset core.gitProxy
}

list_proxy() {
./main.sh << EOF
list
1
y
0
EOF
}

if [ "$1"X = "set"X ]
then
set_proxy_auth
list_proxy
elif [ "$1"X = "unset"X ]
then
unset_proxy
elif [ "$1"X = "list"X ]
then
list_proxy
else
echo "Please try set unset list..."
fi

