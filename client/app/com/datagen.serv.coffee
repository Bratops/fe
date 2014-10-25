"use strict"
angular.module("brasFeApp").service "datagen", ()->
  r = {}

  r.kvp = (n, v)->
    {key: n, value: v}

  r.nvp = (n, v)->
    {name: n, value: v}

  r.date_opt = (min="2014/11/10")->
    minDate: min
    maxDate: "'2014/11/21'"
    open: false
    startingDay: 1

  r.add_day = (base_day, day)->
    dt = base_day || new Date()
    dt.setDate(dt.getDate() + day)
    dt

  r.CSVToArray = (strData, strDelimiter) ->
    # Check to see if the delimiter is defined. If not,
    # then default to comma.
    strDelimiter = (strDelimiter or ",")
    # Create a regular expression to parse the CSV values.
    objPattern = new RegExp( (
      # Delimiters.
      "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +
      # Quoted fields.
      "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +
      # Standard fields.
      "([^\"\\" + strDelimiter + "\\r\\n]*))"), "gi")
    #console.log objPattern
    # Create an array to hold our data. Give the array
    # a default empty first row.
    arrData = [[]]
    # Create an array to hold our individual pattern
    # matching groups.
    arrMatches = null
    # Keep looping over the regular expression matches
    # until we can no longer find a match.
    while arrMatches = objPattern.exec(strData.replace(/\t/g, ","))
      # Get the delimiter that was found.
      strMatchedDelimiter = arrMatches[1]
      # Check to see if the given delimiter has a length
      # (is not the start of string) and if it matches
      # field delimiter. If id does not, then we know
      # that this delimiter is a row delimiter.
      # Since we have reached a new row of data,
      # add an empty row to our data array.
      arrData.push []  if strMatchedDelimiter.length and strMatchedDelimiter isnt strDelimiter
      strMatchedValue = undefined
      # Now that we have our delimiter out of the way,
      # let's check to see which kind of value we
      # captured (quoted or unquoted).
      if arrMatches[2]
        # We found a quoted value. When we capture
        # this value, unescape any double quotes.
        strMatchedValue = arrMatches[2].replace(new RegExp("\"\"", "g"), "\"")
      else
        # We found a non-quoted value.
        strMatchedValue = arrMatches[3]
      # Now that we have our value string, let's add
      # it to the data array.
      arrData[arrData.length - 1].push strMatchedValue
    # Return the parsed data.
    arrData

  r
