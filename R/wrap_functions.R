
#' @import sparklyr
#' @export
spark_hello <- function(sc) {
  sparklyr::invoke_static(sc, "sparklyrExtensionScala.HelloWorld", "hello")
}



#' @import sparklyr
#' @export
regex_other_cleanups <- function(sc) {
  spark_context(sc) %>%
    sparklyr::invoke_static(sc, "sparklyrExtensionScala.regexOtherCleanups", "register_otherCleanups", spark_session(sc))
}