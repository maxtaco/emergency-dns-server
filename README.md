emergency-dns-server
====================

"...For when you are in a *bind*..."


What
----

A very simple, zero-config emergency DNS server.  Use this if
you want to answer some DNS queries, but relegate the majority
of the work to a (real) upstream server.

Install
--------

    npm install emergency-dns-server -g


Running
-------

    ednsd -p 5500 -u 8.8.8.8 www.mysite.com:a:18.26.4.239 boo.com:mx:10.0.0.1


This will set up the emergency DNS server to listen on port 5500,
and to answer `A` queries for `www.mysite.com` with the IP
address `18.26.4.239` and `MX` queries for `boo.com` with the IP
address `10.0.0.1`.  All other requests will be proxied to the upstream
server at `8.8.8.8`

If you don't provide a `-p` flag, `ednsd` will startup on port 53 as
usual.  But note, you'll have to be root to do that.

Building
--------

If you want to change/build this thing from scratch, you'll need one
additional prerequesite --- *IcedCoffeeScript*.  Get it like so:

    npm install iced-coffee-script -g

And then you can build by running:

    icake build

from the top directory.  The file `./cmd.js` is hand-written,
but everything else in `lib/` is generated from a `.iced` file
found in the `src/` directory.

Security
--------

You can supply `-U <user>` and `-G <group>` to have `ednsd`
`setuid` and `setgid` respectively.  This is good for security
if you are running as root and binding to port 53.
