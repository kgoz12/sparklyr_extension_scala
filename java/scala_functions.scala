
package sparklyrExtensionScala

import org.apache.spark.sql.SparkSession;

object HelloWorld{
  def hello() : String = {
    "Hello Jello"
  }
}

object regexOtherCleanups{
  def register_otherCleanups(spark:SparkSession) = {
    spark.udf.register("otherCleanups", (textColumn: String) => {
      val updatedTextColumn = textColumn
      .replaceAll("(?![A-z ]{1,})([+])(?=[A-z ]{1,})", " and ")
      .replaceAll("(^| )(?=)(w/)", " with ")
      .replaceAll(" +", " ")
      updatedTextColumn
    })
  }
}

