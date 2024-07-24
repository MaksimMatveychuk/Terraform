resource "aws_ecs_task_definition" "tertesttd" {

  family = "tertesttd"

  container_definitions = jsonencode([
    {
      name              = "container",
      image             = "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-north-1.amazonaws.com/backrepository:latest",
      cpu               = 0,
      memory            = 819,
      memoryReservation = 819,
      portMappings = [
        {
          name          = "continer-8080-tcp",
          containerPort = 8080,
          hostPort      = 8080,
          protocol      = "tcp",
          appProtocol   = "http"
        }
      ],
      essential = true,
      environment = [
        {
          name  = "POSTGRES_USER",
          value = "postgres"
        },
        {
          name  = "PG_USERNAME",
          value = "postgres"
        },
        {
          name  = "PG_HOST",
          value = aws_db_instance.postgres.address
        },
        {
          name  = "PG_PASSWORD",
          value = "postgres"
        },
        {
          name  = "PG_DATABASE",
          value = "postgres"
        },
        {
          name  = "POSTGRES_PASSWORD",
          value = "postgres"
        },
        {
          name  = "POSTGRES_DB",
          value = "postgres"
        }
      ],
      mountPoints = [],
      volumesFrom = [],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/td-test",
          awslogs-create-group  = "true",
          awslogs-region        = "eu-north-1",
          awslogs-stream-prefix = "ecs"
        },
        secretOptions = []
      },
      systemControls = []
    }
  ])

  task_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  #   execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode       = "bridge"
  requires_compatibilities = [
    "EC2"
  ]
  cpu    = "1024"
  memory = "923"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  depends_on = [null_resource.docker_packaging]
}