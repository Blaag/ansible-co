BEGIN {
  modelRegex1 = "cisco .* with [0-9/K]+ bytes of memory\."
  modelRegex2 = "cisco Nexus[0-9]+ [A-Z0-9]+ "
  modelRegex3 = "cisco .* with [0-9]+K bytes of physical memory\."
  ciscoPlatformRegex1 = "Cisco IOS Software, .* Version "
  ciscoPlatformRegex2 = "Cisco IOS Software, IOS-XE Software"
  ciscoPlatformRegex3 = "Cisco IOS XR Software, Version "
  ciscoPlatformRegex4 = "Cisco Nexus Operating System"
  foundModelCount = 0
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
}
END {
  print ciscoPlatform
  print modelNumber
}

