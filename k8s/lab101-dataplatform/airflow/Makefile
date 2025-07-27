create-admin-user:
	kubectl exec -n lab101-airflow lab101-airflow-webserver-0 -- \
		airflow users create \
			--username airflow \
			-f Airflow \
			-l Airflow \
			--role Admin \
			--email phamtanvinh.me@gmail.com
