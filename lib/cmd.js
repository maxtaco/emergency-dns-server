#!/usr/bin/env node

//=======================================================================

var argv = require('optimist')
    .usage("Usage: $0 [-p <port>] [-u <upstream>] <res1> <res2> ...")
    .demand(['u'])
    .argv;

//=======================================================================

var path = require('path');
var fs   = require('fs');

//=======================================================================

require("./server").run(argv)
