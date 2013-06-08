name "webserver"
description "Configure node as a webserver."
default_attributes(
  "apache" => {
    "listen_ports" => ["80", "443"],
    "contact" => "gsvicky@gmail.com",
    "default_modules" => ["status","alias","autoindex","dir","env","mime","negotiation","setenvif"]
  }
)
override_attributes()
run_list(
  "recipe[apache2::default]",
  "recipe[apache2::mod_ssl]",
  "recipe[ohai]",
  "recipe[custom-setup]"
)