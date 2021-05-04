
#' @import sparklyr
#' @export
spark_hello <- function(sc) {
  sparklyr::invoke_static(sc, "sparklyrExtensionScala.HelloWorld", "hello")
}

#' @import sparklyr
#' @export
regex_other_cleanups <- function(sc) {
  sparklyr::invoke_static(sc, "sparklyrExtensionScala.regexOtherCleanups", "otherCleanups")
}