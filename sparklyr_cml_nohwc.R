#CONNECT TO DATA LAKE WITHOUT USING SPARK HWC

#Run this once
install.packages("sparklyr")
install.packages("dplyr")
install.packages("DBI")
install.packages("tidyr")

#Add library
library(sparklyr)
library(dplyr)
library(DBI)
library(tidyr)

#Add spark_config()
spark_config()
config <- spark_config()


#Add configuration

#Replace the Storage Location with your Location here:
config$spark.yarn.access.hadoopFileSystems="s3a://go01-demo"

spark <- spark_connect(config = config)

# Use SQL-style query to get variant information for the variants in Open Targets Genetics
# can use go/arch/hue to search for datasets
# Open targets in hg38

### FinnGen data in hg38
FG = dbGetQuery(spark, paste0("SELECT * ",
                             "FROM default.mytable"))


typeof(FG)

#Creating Spark Dataframe
FG_spark <- copy_to(spark, FG, name = spark_table_name('default.fg_try'), overwrite = TRUE)

#Creating Spark Table - Hive Metastore - External Table
spark_write_table(
  FG_spark, "default.fg_try", "overwrite"
)
