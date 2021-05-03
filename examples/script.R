
# sparklyr::spark_install(version = "3.0.1")

remotes::install_github("kgoz12/sparklyr_extension_scala", force = T)

pacman::p_load("dplyr",
               "sparklyr",
               "sparklyr.nested")

library(sparklyrExtensionScala)

sparklyr::registered_extensions() 

config <- spark_config()
config$sparklyr.log.console <- FALSE
config$spark.sql.shuffle.partitions <- 800
sc <- spark_connect(master = "local", config = config, version = "3.0.1")

sparklyrExtensionScala::spark_hello(sc)

