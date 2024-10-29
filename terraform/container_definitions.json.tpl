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
        "value": "redis://redis:6379/0"
      },
      {
        "name": "CELERY_RESULT_BACKEND",
        "value": "redis://redis:6379/0"
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
    ]
  },
  {
    "name": "redis",
    "image": "${redis_image}",
    "essential": false,
    "memory": 256,
    "cpu": 256,
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
  },
  {
    "name": "celery",
    "image": "${image}",
    "essential": true,
    "environment": [
      {
        "name": "CELERY_BROKER_URL",
        "value": "redis://redis:6379/0"
      },
      {
        "name": "CELERY_RESULT_BACKEND",
        "value": "redis://redis:6379/0"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${ecs_service_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "celery"
      }
    },
    "dependsOn": [
      {
        "containerName": "redis",
        "condition": "START"
      }
    ]
  },
  {
    "name": "celery-beat",
    "image": "${image}",
    "essential": true,
    "environment": [
      {
        "name": "CELERY_BROKER_URL",
        "value": "redis://redis:6379/0"
      },
      {
        "name": "CELERY_RESULT_BACKEND",
        "value": "redis://redis:6379/0"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${ecs_service_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "celery-beat"
      }
    },
    "dependsOn": [
      {
        "containerName": "redis",
        "condition": "START"
      }
    ]
  }
]
