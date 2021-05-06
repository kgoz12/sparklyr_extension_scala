test_that("check otherCleanups function", {
  
  library(sparklyrExtensionScala)
  library(dplyr)
  
  # connect to spark
  config <- sparklyr::spark_config()
  config$`sparklyr.shell.driver-memory` <- "16G"
  config$spark.sql.shuffle.partitions <- 800
  sc <- sparklyr::spark_connect(master = "local", version = "3.0.1", config = config)
  
  # make toy dataset for testing
  toy_local_frame <- as.data.frame(
    matrix(c("mac + cheese 4 lunch",
             "dog w/ toy")))
  colnames(toy_local_frame) <- c("text")
  spark_toy_frame <- sparklyr::sdf_copy_to(
    sc,
    toy_local_frame,
    name = "spark_toy_frame",
    overwrite = T,
    memory = T)
  
  # does this register my custom function as an add-on?
  regex_other_cleanups(sc)
  
  # frame post function transformation
  test_frame <- spark_toy_frame %>%
    mutate(prettyText = otherCleanups(text)) %>%
    select(prettyText)
  
  # make a post transformation frame for comparison purposes
  local_good_frame <- as.data.frame(
    matrix(c("mac and cheese 4 lunch", 
             "dog with toy")))
  colnames(local_good_frame) <- c("prettyText")
  good_frame <- sparklyr::sdf_copy_to(
    sc,
    local_good_frame,
    name = "good_frame",
    overwrite = T,
    memory = T)
  
  expect_equal(test_frame %>% sdf_collect(), good_frame %>% sdf_collect())
  
  spark_disconnect(sc)
})
