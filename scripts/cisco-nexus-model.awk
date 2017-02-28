BEGIN {
  nexusChassisRegexp1 = "NAME: Chassis,  DESCR: Nexus[0-9]+ [A-Z0-9]+.* Chassis"
  nexusChassisRegexp2 = "NAME: Chassis, DESCR: Nexus[0-9]+ Chassis"
  platformFound = 0
  grabNextLine = 0
}
{
  if (grabNextLine) {
    nexusPlatform = $2
    platformFound++
    grabNextLine = 0
  }

  if (match($0, nexusChassisRegexp1)) {
    nexusPlatform = $5
    platformFound++
  }

  if (match($0, nexusChassisRegexp2)) {
    grabNextLine = 1
  }
}
END {
  print nexusPlatform
}
