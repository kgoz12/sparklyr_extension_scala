

spark_dependencies <- function(spark_version, scala_version, ...) {
  
  sparklyr::spark_dependency(
    jars = c(
      system.file(
        sprintf("java/sparklyrExtensionScala-3.0-2.12.jar", spark_version, scala_version),
        package = "sparklyrExtensionScala"
      )
    ),
    packages = c()
  )
}

.onLoad <- function(libname, pkgname){
  sparklyr::register_extension(pkgname)
}