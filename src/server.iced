dns = require 'native-dns'
path = require 'path'
fs = require 'fs'

##=======================================================================

exports.Server = class Server

  #-----------------------------------------
  
  constructor : (@port) ->
    @port = 53
    @server = dns.createServer()
    @tab = {}

  #-----------------------------------------
  
  setHooks : () ->
    @server.on 'request', ( (args...) => @request args...)
    @server.on 'error',   ( (args...) => @error args... )
    
    @server.on 'socketError', (err) =>
      console.log "[E] Error binding to port #{@port}: #{err}"
    @server.on 'listening', () =>
      console.log "[I] Listening on port #{@port}"
    @server.on 'close', () ->
      console.log "[E] Server closed.."
    
  #-----------------------------------------
  
  run : ->
    @setHooks()
    @server.serve @port
    @make_secure()

  #-----------------------------------------
  
  error : (err, buff, req, res) ->
    console.log "[E] Error: #{JSON.stringify err.stack}"

  #-----------------------------------------

  resolve_locally : (q) ->
    ret = null
    
    if (rec = @tab[q.name])? and (a = rec[q.type])?
      ret = 
        name : q.name
        type : q.type
        class : q.class
        ttl : 30
        address : a

    console.log "++ Local #{q.name}/#{q.type} -> #{JSON.stringify ret}"
        
    return ret
 
  #-----------------------------------------

  resolve_recursively : (q, cb) ->
    name = q.name
    type = dns.consts.QTYPE_TO_NAME[q.type]
    
    console.log "+ Recursive lookup for #{name}/#{type}"
    rreq = new dns.Request
      question : new dns.Question { name, type }
      server : { address : @upstream, port: 53, type: 'udp' }
      timeout : 1000

    res = []

    rreq.on 'timeout', () =>
      console.log "[T] Timed out talking to #{@upstream}"
      
    rreq.on 'message', (err, answer) =>
      if answer.answer?
        for a in answer.answer
          console.log "++ Reply: #{name}/#{type} -> #{JSON.stringify a}"
          res.push a
      else if err
        console.log "[E] Error in #{name}/#{type} -> #{err}"

    await 
      rreq.send()
      rreq.on 'end', defer()

    console.log "+ Finish lookup for #{name}/#{type}"
    cb res

  #-----------------------------------------

  parse_resolution : (r) ->
    x = r.split ':'
    if x.length isnt 3
      throw "Resolution is malformed; need 3 parts: #{r}"
    else
      [ from, typ, to ] = x
      if not (qtyp = dns.consts.NAME_TO_QTYPE[typ.toUpperCase()])?
        throw "Unknown query type: #{typ}"
      else
        @tab[from] = {} unless @tab[from]?
        @tab[from][qtyp] = to
        console.log "[I] Resolving #{from}/#{typ} -> #{to}"
 
  #-----------------------------------------

  do_version : (cb) ->
    
    await fs.realpath __filename, defer err, res
    if err
      throw "Can't resolve realpath #{__filename}: #{err}"
      
    dirname = path.dirname res
    pkg = path.join dirname, '..', 'package.json'
    await fs.readFile pkg, 'utf8', defer err, data
    if err
      throw "Can't read #{pkg}: #{err}"
    j = JSON.parse data
    console.log "ednsd version #{j.version}"

    cb()
     
  #-----------------------------------------
  
  parse_args : (argv, cb) ->
    ret = true
    if argv.v
      await @do_version defer()
      ret = false
    else if not (@upstream = argv.u)?
      console.log "[E] -u<upstream> is required! Please provide a server"
      ret = false
    else
      @port = argv.p if argv.p?
      for a in argv._
        @parse_resolution a
      
      @uid = argv.U
      @gid = argv.G

      console.log "[I] Upstream server is: #{@upstream}"
    cb ret
 
  #-----------------------------------------

  make_secure : () ->
    u = process.getuid()
    if u is 0
      if @gid
        console.log "[I] setgid to #{@gid}"
        process.setgid @gid
      if @uid
        console.log "[I] setuid to #{@uid}"
        process.setuid @uid
      
   
  #-----------------------------------------

  resolve : (q, cb) ->
    r = @resolve_locally q
    if r?
      r = [ r ]
    else
      await @resolve_recursively q, defer r
    cb r    
   
  #-----------------------------------------
  
  request : (req, res) ->
    for q in req.question
      await @resolve q, defer results
      for r in results
        res.answer.push r
    res.send()
    
##=======================================================================

exports.run = (argv) ->
  s = new Server
  await s.parse_args argv, defer ret
  s.run() if ret

##=======================================================================
