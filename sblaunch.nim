import std/httpclient, strutils, osproc, parsecfg, os
var dict:Config
var sbcmd:string
var loginurl:string
var usage:string = "Usage: sblaunch [username] [password]\nIf no username and password are passed on commandline, checks sblaunch.ini for [Credentials] section and \"username\" and \"password\" values."
try:
  dict = loadConfig("sblaunch.ini")
except:
  echo "No sblaunch.ini found, proceeding with defaults..."
try:
  sbcmd = dict.getSectionValue("Parameters", "sbcmd")
  loginurl = dict.getSectionValue("Parameters","loginurl")
except:
  sbcmd = "/connetip:51.83.37.56 /connetport:10001 /clientauthcode:^ /clientauthid:25c883fec75407f3de4fa05330ac302c"
  loginurl = "http://oauth.vendettagn.com/auth_login.php"
var username:string 
var password:string
var client = newHttpClient()
var data: MultipartData = newMultipartData()
try:
  if paramCount() < 2:
    raise newException(ValueError, usage)
  else:
    data["username"] = paramStr(1)
    data["password"] = paramStr(2)
except:
  data["username"] = dict.getSectionValue("Credentials", "username")
  data["password"] = dict.getSectionValue("Credentials", "password")
  if dict.getSectionValue("Credentials", "username") == "":
    raise newException(KeyError,"No commandline username value passed and no username provided in sblaunch.ini\n" & usage)
  if dict.getSectionValue("Credentials", "password") == "":
    raise newException(KeyError,"No commandline password value passed and no password provided in sblaunch.ini\n" & usage)
  echo "Username and password read from sblaunch.ini file..."
try:
  var code = client.postContent(loginurl, multipart=data).split("&")[1].split("=")[1]
  client.close()
  discard execCmd(@["sb.exe ", sbcmd.replace("^",code)].join())
except:
  echo "Invalid username/password."
finally:
  client.close()
