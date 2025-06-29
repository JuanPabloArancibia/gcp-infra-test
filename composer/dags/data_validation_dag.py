from airflow import models
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from airflow.models import Variable
from airflow.utils.dates import days_ago
from google.cloud import bigquery
import logging

default_args = {
    'start_date': days_ago(1),
}

# ⚠️ Estas variables deben ser creadas manualmente en Composer (Airflow UI):
# project_id         → ID del proyecto GCP
# bq_dataset_name    → Nombre del dataset creado con Terraform
# bq_table_name      → Nombre de la tabla creada
# validation_query   → (opcional) SQL personalizada; default: COUNT(*)
# La otra opción es agregar las variables a compser desde ci/cd

PROJECT_ID = Variable.get("project_id")
BQ_DATASET = Variable.get("bq_dataset_name")
BQ_TABLE = Variable.get("bq_table_name")

# Consulta de validación configurable
VALIDATION_QUERY = Variable.get(
    "validation_query",
    default_var=f"SELECT COUNT(*) as total FROM `{PROJECT_ID}.{BQ_DATASET}.{BQ_TABLE}`"
)

with models.DAG(
    dag_id="data_validation_dag",
    schedule_interval="@daily",
    default_args=default_args,
    catchup=False,
    tags=["validation", "bigquery"],
) as dag:

    run_validation_query = BigQueryInsertJobOperator(
        task_id="run_validation_query",
        configuration={
            "query": {
                "query": VALIDATION_QUERY,
                "useLegacySql": False,
            }
        },
        location="US"
    )

    def fail_if_zero(**kwargs):
        client = bigquery.Client(project=PROJECT_ID)
        result = client.query(VALIDATION_QUERY).result()
        row = list(result)[0]
        total = row["total"]

        logging.info(f"Resultado de la validación: total = {total}")
        if total == 0:
            raise ValueError("La validación falló: la tabla está vacía")

    check_result = PythonOperator(
        task_id="check_validation_result",
        python_callable=fail_if_zero,
        provide_context=True
    )

    run_validation_query >> check_result