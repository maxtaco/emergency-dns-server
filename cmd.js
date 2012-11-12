#!/usr/bin/env node

//=======================================================================

var argv = require('optimist')
    .usage(["Usage: $0 [-p <port>] [-u <upstream>] <res1> <res2> ...",
	    "",
	    "  This is an emergency DNS server.  Use it make a few resolutions",
	    "  and then to forward the rest to a real DNS server.",
	    "",
	    "OPTIONS",
	    "  -p <port>       listen on a non-standard port (53 by default)",
	    "  -u <upstream>   IP or DNS name of an upstream DNS server " +
	    "(required)",
	    "",
	    "RESOLUTIONS",
	    "",
	    "  Resolutions are of the form <name>:<typ>:<ip>. So, if for",
	    "  example you want to make an 'A' record for 'foo.com' to",
	    "  resolve to 192.0.0.1, you would give the argument:",
	    "",
	    "        foo.com:A:192.0.0.1",
	    "",
	    "  Of course, you can give several of these.",
	    "",
	    "EXAMPLE",
	    "",
	    "  $0 -u 8.8.8.8 my.site.com:a:10.0.0.3 my.site.com:mx:10.0.0.2",
	    "",
	    "SECURITY",
	    "  The following options can be used if you want more security",
	    "  when running as root (and binding to port 53):",
	    "",
	    "  -U <uid>     setuid to this uid/username",
	    "  -G <gid>     setgid to this gid/groupname",
	   ].join("\n"))
    .argv;

//=======================================================================

var path = require('path');
var fs   = require('fs');

//=======================================================================

require("./lib/server").run(argv)
