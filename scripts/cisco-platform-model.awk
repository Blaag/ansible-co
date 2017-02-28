BEGIN {
  modelRegex1 = "cisco .* with [0-9/K]+ bytes of memory\."
  modelRegex2 = "cisco Nexus[0-9]+ [A-Z0-9]+ "
  modelRegex3 = "cisco .* with [0-9]+K bytes of physical memory\."
  ciscoPlatformRegex1 = "Cisco IOS Software, .* Version "
  ciscoPlatformRegex2 = "Cisco IOS Software, IOS-XE Software"
  ciscoPlatformRegex3 = "Cisco IOS XR Software, Version "
  ciscoPlatformRegex4 = "Cisco Nexus Operating System"

  # for ios and some ios-xe
  ciscoVersionRegex1 = "Cisco IOS Software, .* Version .*"
  # for older nxos platforms
  ciscoVersionRegex2 = " +system: +version .*"
  # for newer nxos platforms
  ciscoVersionRegex3 = " +NXOS: version .*"
  # for ios-xr
  ciscoVersionRegex4 = "Cisco IOS XR Software, Version .*"
  # for some ios-xe
  ciscoVersionRegex5 = "IOS XE Version: .*"

  foundModelCount = 0
  foundPlatformCount = 0
  foundVersionCount = 0
  
  modelNumber = "undetermined"
}
{
  if (match($0, modelRegex1)) {
    foundModelCount++
    modelNumber = $2
  }

  if (match($0, modelRegex2)) {
    foundModelCount++
    modelNumber = $3
  }

  if (match($0, modelRegex3)) {
    foundModelCount++
    modelNumber = $2
  }

  if ((match($0, ciscoPlatformRegex1)) && ($4 != "IOS-XE")) {
    ciscoPlatform = "ios"
    foundPlatformCount++
  }

  if (match($0, ciscoPlatformRegex2)) {
      ciscoPlatform = "iosxe"
      foundPlatformCount++
  }

  if (match($0, ciscoPlatformRegex3)) {
      ciscoPlatform = "iosxr"
      foundPlatformCount++
  }

  if (match($0, ciscoPlatformRegex4)) {
      ciscoPlatform = "nxos"
      foundPlatformCount++
  }

  if (match($0, ciscoVersionRegex1)) {
    # find where the version string is located
    stringLoc = match($0, "Version")

    # strip everything up to the word just past it which will be
    # the version number
    subStr = substr($0, stringLoc + 8, length($0))
    stringLoc = match(subStr, " ")

    # strip anything after the version number
    versionNumber = substr(subStr, 0, stringLoc - 1)

    # some ios version strings have a trailing comma - strip it
    if (substr(versionNumber, length(versionNumber), 1) == ",") {
      versionNumber = substr(versionNumber, 0, length(versionNumber) - 1)
    }

    # determine the major version number
    split(versionNumber, maj, ".")

    if (maj[1] < 12) {
      # sometimes the banner lists the ios "equivalent" of the ios-xe version
      # which is incorrect, the ios-xe version is needed
      # ios-xe version are always lower than ios versions
      # so if we see a number 12 or higher, its likely the wrong
      # value being detected
      foundVersionCount++
    }
  }

  if (match($0, ciscoVersionRegex2)) {
    versionNumber = $3
    foundVersionCount++
  }

  if (match($0, ciscoVersionRegex3)) {
    versionNumber = $3
    foundVersionCount++
  }

  if (match($0, ciscoVersionRegex4)) {
    subStr = $6
    stringLoc = match(subStr, "\\[")
    versionNumber = substr(subStr, 0, stringLoc - 1)
  }

  if (match($0, ciscoVersionRegex5)) {
    versionNumber = $4
    foundVersionCount++
  }

}
END {
  print ciscoPlatform
  print modelNumber
  print versionNumber
}
