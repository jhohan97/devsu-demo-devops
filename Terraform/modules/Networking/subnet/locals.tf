locals {
   transformed_type = replace(
    replace(
      replace(var.subnet_config.type, "public", "pub"),"private", "prv"
    ),"protected", "prt"
  )
}