[
  {
    "name": "app",
    "image": "761940244621.dkr.ecr.ap-northeast-1.amazonaws.com/techbooklabo-v1-app",
    "cpu": 200,
    "memory": null,
    "memoryReservation": 600,
    "essential": true,
    "command": ["php", "artisan", "migrate", "--force"],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "migration",
        "awslogs-region": "ap-northeast-1",
        "awslogs-stream-prefix": "app-migration"
      }
    },
    "environment": [
      {
        "name": "APP_NAME",
        "value": "techbooklabo"
      },
      {
        "name": "APP_ENV",
        "value": "production"
      },
      {
        "name": "APP_KEY",
        "value": "${app_key}"
      },
      {
        "name": "APP_URL",
        "value": "${app_url}"
      },
      {
        "name": "APP_DEBUG",
        "value": "false"
      },
      {
        "name": "TZ",
        "value": "Asia/Tokyo"
      },
      {
        "name": "DB_CONNECTION",
        "value": "mysql"
      },
      {
        "name": "DB_HOST",
        "value": "${db_host}"
      },
      {
        "name": "DB_PORT",
        "value": "3306"
      },
      {
        "name": "DB_DATABASE",
        "value": "${db_database}"
      },
      {
        "name": "DB_USERNAME",
        "value": "${db_username}"
      },
      {
        "name": "DB_PASSWORD",
        "value": "${db_password}"
      }
   ]
  }
]