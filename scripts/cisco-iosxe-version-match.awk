# script expects two arguments
#
# IOSXE proposed version in the form of the filename
# IOSXE version as scraped from the top line of the "show version" command
#
# Cisco uses various formats of displaying their IOSXE version, for example
# 03.06.04.E and
# 03.06.04E
#
# The script will determine which known version is being used and then
# print a single line of output which is the version found in the
# filename transformed into the correct format
#
# For example, if the proposed software version filename is
# cat3k_caa-universalk9.SPA.03.06.06.E.152-2.E6.bin
# and the IOSXE version from "show version" is
# 03.06.04E
# then the output of the script will be "03.06.06E" (the last dot
# was stripped to match the "show version" format)
#
BEGIN {
  iosxeVersionRegexp1 = "[0-9][0-9]\.[0-9][0-9]\.[0-9][0-9][A-Z]"
  iosxeVersionRegexp2 = "[0-9][0-9]\.[0-9][0-9]\.[0-9][0-9]\.[A-Z]"
  iosxeFileRegexp = "\.[0-9][0-9]\.[0-9][0-9]\.[0-9][0-9]\.[A-Z]\."
  foundVersion = 0
}
{
  iosFile = $1
  iosShowVer = $2

  if (match($2, iosxeVersionRegexp1) && !foundVersion) {
    foundVersion = 1
    #print "matched iosxeVersionRegexp1"
    # pull relevant version piece from the file name
    strLoc = match($1, iosxeFileRegexp)
    firstPiece = substr($1, strLoc + 1, length($1))
    split(firstPiece, vComps, ".")
    FileShorthand = vComps[1] "." vComps[2] "." vComps[3] "" vComps[4]
  }

  if (match($2, iosxeVersionRegexp2) && !foundVersion) {
    foundVersion = 1
    #print "matched iosxeVersionRegexp2"
    # pull relevant version piece from the file name
    strLoc = match($1, iosxeFileRegexp)
    firstPiece = substr($1, strLoc + 1, length($1))
    split(firstPiece, vComps, ".")
    FileShorthand = vComps[1] "." vComps[2] "." vComps[3] "." vComps[4]
  }

}
END {
  print FileShorthand
}

