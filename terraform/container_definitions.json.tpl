[
  {
    "name": "${container_name}",
    "image": "${image}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${container_port},
        "protocol": "tcp"
      }
    ],
   "environment": [
  {
    "name": "DJANGO_SETTINGS_MODULE",
    "value": "celery_example.settings"
  },
  {
    "name": "CELERY_BROKER_URL",
    "value": "redis://localhost:6379/0"
  },
  {
    "name": "CELERY_RESULT_BACKEND",
    "value": "redis://localhost:6379/0"
  }
],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${ecs_service_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${container_name}"
      }
    },
    "dependsOn": [
      {
        "containerName": "redis",
        "condition": "START"
      }
    ],
    "command": ["/app/docker-entrypoint.sh"]
  },
  {
    "name": "redis",
    "image": "${redis_image}",
    "essential": false,
    "memory": 256,
    "cpu": 128,
    "portMappings": [
      {
        "containerPort": 6379,
        "hostPort": 6379,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${ecs_service_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "redis"
      }
    }
  }
]
