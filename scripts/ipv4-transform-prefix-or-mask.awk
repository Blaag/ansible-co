function prefixToMask(prefix) {
  if (prefix == "/32") { mask = "255.255.255.255" }
  if (prefix == "/31") { mask = "255.255.255.254" }
  if (prefix == "/30") { mask = "255.255.255.252" }
  if (prefix == "/29") { mask = "255.255.255.248" }
  if (prefix == "/28") { mask = "255.255.255.240" }
  if (prefix == "/27") { mask = "255.255.255.224" }
  if (prefix == "/26") { mask = "255.255.255.192" }
  if (prefix == "/25") { mask = "255.255.255.128" }
  if (prefix == "/24") { mask = "255.255.255.0" }
  if (prefix == "/23") { mask = "255.255.254.0" }
  if (prefix == "/22") { mask = "255.255.252.0" }
  if (prefix == "/21") { mask = "255.255.248.0" }
  if (prefix == "/20") { mask = "255.255.240.0" }
  if (prefix == "/19") { mask = "255.255.224.0" }
  if (prefix == "/18") { mask = "255.255.192.0" }
  if (prefix == "/17") { mask = "255.255.128.0" }
  if (prefix == "/16") { mask = "255.255.0.0" }
  if (prefix == "/15") { mask = "255.254.0.0" }
  if (prefix == "/14") { mask = "255.252.0.0" }
  if (prefix == "/13") { mask = "255.248.0.0" }
  if (prefix == "/12") { mask = "255.240.0.0" }
  if (prefix == "/11") { mask = "255.224.0.0" }
  if (prefix == "/10") { mask = "255.192.0.0" }
  if (prefix == "/9") { mask = "255.128.0.0" }
  if (prefix == "/8") { mask = "255.0.0.0" }

  return mask
}

function maskToPrefix(mask) {

  if (mask == "255.255.255.255") { prefix = "/32" }
  if (mask == "255.255.255.254") { prefix = "/31" }
  if (mask == "255.255.255.252") { prefix = "/30" }
  if (mask == "255.255.255.248") { prefix = "/29" }
  if (mask == "255.255.255.240") { prefix = "/28" }
  if (mask == "255.255.255.224") { prefix = "/27" }
  if (mask == "255.255.255.192") { prefix = "/26" }
  if (mask == "255.255.255.128") { prefix = "/25" }
  if (mask == "255.255.255.0") { prefix = "/24" }
  if (mask == "255.255.254.0") { prefix = "/23" }
  if (mask == "255.255.252.0") { prefix = "/22" }
  if (mask == "255.255.248.0") { prefix = "/21" }
  if (mask == "255.255.240.0") { prefix = "/20" }
  if (mask == "255.255.224.0") { prefix = "/19" }
  if (mask == "255.255.192.0") { prefix = "/18" }
  if (mask == "255.255.128.0") { prefix = "/17" }
  if (mask == "255.255.0.0") { prefix = "/16" }
  if (mask == "255.254.0.0") { prefix = "/15" }
  if (mask == "255.252.0.0") { prefix = "/14" }
  if (mask == "255.248.0.0") { prefix = "/13" }
  if (mask == "255.240.0.0") { prefix = "/12" }
  if (mask == "255.224.0.0") { prefix = "/11" }
  if (mask == "255.192.0.0") { prefix = "/10" }
  if (mask == "255.128.0.0") { prefix = "/9" }
  if (mask == "255.0.0.0") { prefix = "/8" }

  return prefix
}

BEGIN {
}
{
  if (match($1, "/[0-9]+")) {
    print prefixToMask($1)
  }

  if (match($1, "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")) {
    print maskToPrefix($1)
  }
}
END {
}

