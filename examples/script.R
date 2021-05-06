
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

toy_local_frame <- as.data.frame(matrix(c("k citrate izzzz good.",
                                          "mac + cheese 4 lunch",
                                          "dog w/ toy",
                                          "this is nice pretty text!")))
colnames(toy_local_frame) <- c("text")
spark_toy_frame <- sparklyr::sdf_copy_to(sc, 
                                         toy_local_frame, 
                                         name = "spark_toy_frame", 
                                         overwrite = T, 
                                         memory = T)

regex_other_cleanups(sc)

try_this <- spark_toy_frame %>%
  mutate(tryThis = otherCleanups(text))

head(try_this)




