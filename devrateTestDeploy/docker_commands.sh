#!/bin/bash
echo "ECS_CLUSTER=${aws_ecs_cluster.cluster_back.name}" >> /etc/ecs/ecs.config