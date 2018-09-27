#!/bin/bash

az group create -n jenkins -l eastus --tags Remove=no
az storage account create -n ipjenkinssa -g jenkins -l eastus --sku Standard_LRS
conn=$(az storage account show-connection-string -n ipjenkinssa -g jenkins -o tsv)
az storage share create -n jenkins --connection-string $conn
key=$(az storage account keys list -n ipjenkinssa -g jenkins --query [0].value -o tsv)
az container create \
    -g jenkins \
    -n jenkinsgroup \
    --image tripdubroot/jenkins:scala \
    --ip-address public \
    --ports 8080 50000 \
    --azure-file-volume-share-name jenkins \
    --azure-file-volume-account-name ipjenkinssa \
    --azure-file-volume-account-key $key \
    --azure-file-volume-mount-path /var/jenkins_home \
    --dns-name-label sejenkins \
    --cpu 2 \
    --memory 8
