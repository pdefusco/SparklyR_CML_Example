# SparklyR CML Example

Cloudera Machine Learning (CML) is Cloudera’s new cloud-native machine learning service, built for CDP. Cloudera Machine Learning unifies self-service data science and data engineering in a single, portable service as part of an enterprise data cloud for multi-function analytics on data anywhere.

CML Users leverage Runtimes to quickly launch Sessions with custom dependencies. The R runtime can be used in conjunction with the Spark Add-On to leverage the full scalability of Spark and work with massive datasets with libraries such as sparklyR.

You can use Spark to read and write data to Hive External tables without the Hive Warehouse Connector. The following example showcases how to do this with SparklyR in CML. To learn more about the Hive Metastore and Hive Warehouse Connector please scroll down to the "Hive Warehouse Connector vs Hive Metastore" section below.

### Requirements

In order to reproduce this example you will need:

* A CML Workspace (Azure, AWS, Cloudera ECS or OCP ok).
* Basic working knowledge of R and Spark.
* An existing table to read data from. If you don't have one you can modify the script to create one.
* The value of the Storage Location variable for your CDP Environment. If you don't know it you can get this from the CDP Management Console or ask your CDP Admin.

### Instructions

Launch a CML Session with the following configurations:

```
Resource Profile: 1 vCPU - 2 GiB Mem - 0 GPU
Kernel: R 4.1
Editor: Workbench
Edition: Standard
Version: any available version ok
Enable Spark: Spark 3.2.0
```

In the Session, run the entire "sparklyr_connect.R" script by clicking "Run" -> "Run All" in the top menu.

Validate outputs on the right pane.

### Understanding the Code

At a high level, the script reads data from a Hive External table. It then creates a Spark Dataframe and finally write the data to a new Hive External Table. It's important to notice the following:

* Line 23: the Storage location is dependent on the CDP Data Lake (Environment). Each CML Workspace is associated with an AWS, Azure, HDFS or Ozone Cloud Storage Location. You must change this value according to your Workspace Deployment.

* Line 32: the dbGetQuery method is used to READ data from an existing Hive External Table. Notice the database name is "default". You must change this value according to your database and table name.

* Line 39 and 43: The database and table name argument in the two method calls must match. Notice the "overwrite" argument at line 43 and plan accordingly if you are testing with an existing table.


### Hive Warehouse Connector vs Hive Metastore

Spark SQL uses a Hive metastore to manage the metadata of persistent relational entities (e.g. databases, tables, columns, partitions) in a relational database (for fast access). A Hive metastore warehouse (aka spark-warehouse) is the directory where Spark SQL persists tables whereas a Hive metastore (aka metastore_db) is a relational database to manage the metadata of the persistent relational entities, e.g. databases, tables, columns, partitions.

HWC is software for securely accessing Hive tables from Spark. You need to use the HWC if you want to access Hive managed tables from Spark. You explicitly use HWC by calling the HiveWarehouseConnector API to write to managed tables. You might use HWC without even realizing it. HWC implicitly reads tables when you run a Spark SQL query on a Hive managed table.

You do not need HWC to read or write Hive external tables. You can use native Spark SQL. Spark tables will be tracked in the HMS. In this tutorial we did not use the HWC to work with our data in CML.

## Conclusions and Next Steps

CDP Machine Learning enables enterprise data science teams to collaborate across the full data lifecycle with immediate access to enterprise data pipelines, scalable compute resources, and access to preferred tools.

With R Runtimes and the native integration with the Cloudera Data Platform (CDP) you can easily access data at scale and collaborate with Data Analysts and other project stakeholders. For example, you can access data from CDW via a CML Session to read and write data without the Hive Warehouse Connector. 

To learn more about the Cloudera Machine Learning Service please visit the documentation at [this page](https://docs.cloudera.com/machine-learning/cloud/product/topics/ml-product-overview.html).

If you are evaluating CML you may also benefit from testing the following demos:

* [Telco Churn Demo](https://github.com/pdefusco/CML_AMP_Churn_Prediction): Build an End to End ML Project in CML and Increase ML Explainability with the LIME Library.
* [Learn how to use Cloudera Applied ML Prototypes](https://docs.cloudera.com/machine-learning/cloud/applied-ml-prototypes/topics/ml-amps-overview.html) to discover more projects using MLFlow, Streamlit, Tensorflow, PyTorch and many more popular libraries.
* [CSA2CML](https://github.com/pdefusco/CSA2CML): Build a real time anomaly detection dashboard with Flink, CML, and Streamlit.
* [SDX2CDE](https://github.com/pdefusco/SDX2CDE): Explore ML Governance and Security features in SDX to increase legal compliance and enhance ML Ops best practices.
* [API v2](https://github.com/pdefusco/CML_AMP_APIv2): Familiarize yourself with API v2, CML's goto Python Library for ML Ops and DevOps.
