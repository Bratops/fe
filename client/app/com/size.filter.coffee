"use strict"
angular.module("brasFeApp").filter "bytes", ->
  (bytes, precision) ->
    return "0 bytes"  if bytes is 0
    return "-"  if isNaN(parseFloat(bytes)) or not isFinite(bytes)
    precision = 1  if typeof precision is "undefined"
    units = [ "bytes", "kB", "MB", "GB", "TB", "PB" ]
    number = Math.floor(Math.log(bytes) / Math.log(1024))
    val = (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision)
    ((if val.match(/\.0*$/) then val.substr(0, val.indexOf(".")) else val)) + " " + units[number]
