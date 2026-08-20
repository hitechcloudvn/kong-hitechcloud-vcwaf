package = "kong-hitechcloud-vcwaf"
version = "1.0.3-1"
source = {
   url = "file://kong-hitechcloud-vcwaf-1.0.3.tar.gz",
}
build = {
  type = "script",
  rockspec = {
    build = {
      "git clone https://github.com/hitechcloud-vietnam/HiTechCloud vCWAF.git",
      "cp -r sdk/kong .",
      "rm -rf HiTechCloud vCWAF"
    }
  }
}
description = {
   summary = "Kong plugin for HiTechCloud vCWAF Web Application Firewall",
   homepage = "https://github.com/hitechcloud-vietnam/HiTechCloud vCWAF",
   license = "Apache License 2.0",
   maintainer = "Xiaobing Wang <xiaobing.wang@hitechcloud-vietnam.com>"
}
dependencies = {
   "lua-resty-t1k >= 1.1.5"
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.hitechcloud-vcwaf.handler"] = "kong/plugins/hitechcloud-vcwaf/handler.lua",
      ["kong.plugins.hitechcloud-vcwaf.schema"] = "kong/plugins/hitechcloud-vcwaf/schema.lua"
   }
}
