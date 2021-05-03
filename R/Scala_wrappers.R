
spark_hello <- function(sc) {
  sparklyr::invoke_static(sc, "SparkHello.HelloWorld", "hello")
}

