
spark_hello <- function(sc) {
  sparklyr::invoke_static(sc, "sparklyrExtensionScala.HelloWorld", "hello")
}

