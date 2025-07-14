import sys
import logging
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, upper, year, current_date, to_date
from awsglue.context import GlueContext
from awsglue.job import Job

logger = logging.getLogger()
logger.setLevel(logging.INFO)

args = getResolvedOptions(sys.argv, ['JOB_NAME', 'INPUT_PATH'])

logger.info("Inicializando Spark e GlueContext...")
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

logger.info(f"Iniciando job: {args['JOB_NAME']}")
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

input_path = args['INPUT_PATH']
logger.info(f"Lendo arquivo de entrada: {input_path}")

df = spark.read.option("header", "true").option("inferSchema", "true").csv(input_path)
logger.info(f"Leitura concluída com {df.count()} registros.")

logger.info("Iniciando transformações no DataFrame...")
df_transformado = df.withColumn("nome", upper(col("nome"))) \
    .withColumn("data_nascimento", to_date(col("data_nascimento"), "yyyy-MM-dd")) \
    .withColumn("idade", year(current_date()) - year(col("data_nascimento"))) \
    .filter(col("pais") == "Brasil")

logger.info(f"Transformações concluídas. Registros filtrados: {df_transformado.count()}")

output_path = "s3://meu-bucket/dados-processados/clientes_brasil/"
logger.info(f"Gravando dados transformados em: {output_path}")

df_transformado.write.mode("overwrite").parquet(output_path)

logger.info("Gravação concluída.")
job.commit()
logger.info(f"Job {args['JOB_NAME']} finalizado com sucesso.")