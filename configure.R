
library(dplyr)

# sparklyr::download_scalac()
# sparklyr::find_scalac("2.12")
# sparklyr::find_scalac("2.11")
# sparklyr::find_scalac("2.10")

# sparklyr::spark_version(sc)

pkg <- sparklyr:::infer_active_package_name() # "sparklyrExtensionScala"

# Compile for Scala - let function determine spark version
spec <- sparklyr::spark_compilation_spec(
  jar_name = sprintf("%s-3.0-2.12.jar", pkg), 
  jar_path = sparklyr:::find_jar(),
  spark_version = "3.0.1",
  scalac_path = sparklyr::find_scalac("2.12"))

sparklyr::compile_package_jars(spec = spec)
