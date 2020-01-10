#!/bin/bash

set -e

. project.config

gcloud projects create $PROJECT_ID --folder $FOLDER_ID

gcloud beta billing projects link $PROJECT_ID --billing-account=$BILLING_ID

cat roles.txt | while read role || [[ -n $role ]];
do
	gcloud projects add-iam-policy-binding $PROJECT_ID --member $OWNER --role $role
done

cat services.txt | while read service || [[ -n $service ]];
do
	gcloud services enable $service --project  $PROJECT_ID 
done
