package = "kong-hitechcloud-vcwaf"
version = "1.0.1-1"
source = {
   url = "https://github.com/hitechcloudvn/kong-hitechcloud-vcwaf.git"
}
description = {
   summary = "Kong plugin for HiTechCloud vCWAF Web Application Firewall",
   homepage = "https://github.com/hitechcloudvn/kong-hitechcloud-vcwaf",
   license = "Apache License 2.0",
   maintainer = "Xiaobing Wang <xiaobing.wang@hitechcloud.vn>"
}
dependencies = {
   "lua-resty-t1k"
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.hitechcloud-vcwaf.handler"] = "kong/plugins/hitechcloud-vcwaf/handler.lua",
      ["kong.plugins.hitechcloud-vcwaf.schema"] = "kong/plugins/hitechcloud-vcwaf/schema.lua"
   }
}
