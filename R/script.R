
# sparklyr::spark_install(version = "3.0.1")

pacman::p_load("dplyr",
               "sparklyr",
               "sparklyr.nested")

sparklyr::registered_extensions() 

config <- spark_config()
config$sparklyr.log.console <- FALSE
config$spark.sql.shuffle.partitions <- 800
sc <- spark_connect(master = "local", config = config, version = "3.0.1")

