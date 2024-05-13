#!/bin/bash

# Definir los endpoints de Temporal
CLUSTER1="192.168.36.102:7233"
CLUSTER2="192.168.36.103:7233"

# Configurar TEMPORAL_CLI_ADDRESS para el primer cluster y crear namespace
export TEMPORAL_CLI_ADDRESS=$CLUSTER1
tctl namespace register default --description "Default namespace for Cluster 1" --retention 24 --history_archival_state disabled --visibility_archival_state disabled

# Configurar TEMPORAL_CLI_ADDRESS para el segundo cluster y crear namespace
export TEMPORAL_CLI_ADDRESS=$CLUSTER2
tctl namespace register default --description "Default namespace for Cluster 2" --retention 24 --history_archival_state disabled --visibility_archival_state disabled

echo "Namespaces creados en ambos clusters."
