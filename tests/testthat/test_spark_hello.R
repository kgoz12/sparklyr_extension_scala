testthat_spark_connection <- function() {
  
  version <- Sys.getenv("SPARK_VERSION", unset = "3.0.1")
  
  spark_installed <- sparklyr::spark_installed_versions()
  if (nrow(spark_installed[spark_installed$spark == version, ]) == 0) {
    options(sparkinstall.verbose = TRUE)
    sparklyr::spark_install(version)
  }
  
  # generate connection if none yet exists
  connected <- FALSE
  if (exists(".testthat_spark_connection", envir = .GlobalEnv)) {
    sc <- get(".testthat_spark_connection", envir = .GlobalEnv)
    connected <- sparklyr::connection_is_open(sc)
  }
  
  if (!connected) {
    config <- sparklyr::spark_config()
    config$`sparklyr.shell.driver-memory` <- "16G"
    
    options(sparklyr.sanitize.column.names.verbose = TRUE)
    options(sparklyr.verbose = TRUE)
    options(sparklyr.na.omit.verbose = TRUE)
    options(sparklyr.na.action.verbose = TRUE)
    #options(sparklyr.log.console = TRUE)
    
    sc <- sparklyr::spark_connect(master = "local", version = version, config = config)
    assign(".testthat_spark_connection", sc, envir = .GlobalEnv)
  }
  
  # retrieve spark connection
  get(".testthat_spark_connection", envir = .GlobalEnv)
}

sc <- testthat_spark_connection()

spark_hello(sc)
regex_other_cleanups(sc)

