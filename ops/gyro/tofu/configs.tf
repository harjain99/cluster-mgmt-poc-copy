
resource "aws_cloudwatch_log_group" "log-group" {
  kms_key_id        = ""
  log_group_class   = "STANDARD"
  name              = "service-46e9080"
  region            = "us-east-1"
  retention_in_days = 0
  skip_destroy      = false
  tags              = {}
  tags_all          = {}
}

resource "aws_ecs_task_definition" "task-definition" {
  container_definitions = jsonencode([{
    cpu         = 128
    environment = []
    essential   = true
    image       = "242040583208.dkr.ecr.us-east-1.amazonaws.com/cluster-management-poc:working-with-aws-creds"
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "service-46e9080"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "awsx-ecs"
      }
    }
    memory      = 512
    mountPoints = []
    name        = "awsx-ecs"
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }]
    systemControls = []
    volumesFrom    = []
  }])
  cpu                      = "256"
  enable_fault_injection   = false
  execution_role_arn       = "arn:aws:iam::242040583208:role/service-execution-09efb7d"
  family                   = "service-6c6e6c22"
  memory                   = "512"
  network_mode             = "awsvpc"
  region                   = "us-east-1"
  requires_compatibilities = ["FARGATE"]
  skip_destroy             = null
  tags                     = {}
  tags_all                 = {}
  task_role_arn            = "arn:aws:iam::242040583208:role/taskRole-bd0c737"
  track_latest             = false
  runtime_platform {
    cpu_architecture        = "ARM64"
    operating_system_family = "LINUX"
  }
}

resource "aws_iam_role_policy_attachment" "service-execution-role-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = "service-execution-09efb7d"
}

resource "aws_iam_role_policy_attachment" "task-role-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = "taskRole-bd0c737"
}

resource "aws_ecs_cluster" "cluster" {
  name     = "cluster"
  region   = "us-east-1"
  tags     = {}
  tags_all = {}
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_service" "service" {
  availability_zone_rebalancing      = "DISABLED"
  cluster                            = "arn:aws:ecs:us-east-1:242040583208:cluster/cluster"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  enable_ecs_managed_tags            = false
  enable_execute_command             = false
  force_delete                       = null
  force_new_deployment               = null
  health_check_grace_period_seconds  = 60
  iam_role                           = "/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  launch_type                        = "FARGATE"
  name                               = "service"
  platform_version                   = "LATEST"
  propagate_tags                     = "NONE"
  region                             = "us-east-1"
  scheduling_strategy                = "REPLICA"
  tags                               = {}
  tags_all                           = {}
  task_definition                    = "service-6c6e6c22:3"
  triggers                           = {}
  wait_for_steady_state              = null
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  load_balancer {
    container_name   = "awsx-ecs"
    container_port   = 8080
    elb_name         = ""
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:242040583208:targetgroup/loadbalancer-7d470c7/402581fc31a904eb"
  }
  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-073147b625fb7e43d"]
    subnets          = ["subnet-0224be5e", "subnet-4430a923", "subnet-794b6333", "subnet-a7234489", "subnet-cc1745c3", "subnet-f7d579c9"]
  }
}

resource "aws_security_group" "security-group-2" {
  description = "Managed by Pulumi"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 65535
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  name                   = "service-sg-6f3f4a1"
  region                 = "us-east-1"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-8b5ce9f1"
}

resource "aws_iam_role" "task-role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = ""
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "taskRole-bd0c737"
  path                  = "/"
  permissions_boundary  = ""
  tags                  = {}
  tags_all              = {}
}

resource "aws_ecr_lifecycle_policy" "repo-lifecycle-policy" {
  policy = jsonencode({
    rules = [{
      action = {
        type = "expire"
      }
      description  = "remove untagged images"
      rulePriority = 1
      selection = {
        countNumber = 1
        countType   = "imageCountMoreThan"
        tagStatus   = "untagged"
      }
    }]
  })
  region     = "us-east-1"
  repository = "fargate-example/repo"
}

resource "aws_lb_target_group" "target-group" {
  connection_termination             = null
  deregistration_delay               = "300"
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = null
  load_balancing_algorithm_type      = "round_robin"
  load_balancing_anomaly_mitigation  = "off"
  load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
  name                               = "loadbalancer-7d470c7"
  port                               = 8080
  preserve_client_ip                 = null
  protocol                           = "HTTP"
  protocol_version                   = "HTTP1"
  proxy_protocol_v2                  = null
  region                             = "us-east-1"
  slow_start                         = 0
  tags                               = {}
  tags_all                           = {}
  target_type                        = "ip"
  vpc_id                             = "vpc-8b5ce9f1"
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 60
    matcher             = "200"
    path                = "/clusters"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    unhealthy_threshold = 5
  }
  stickiness {
    cookie_duration = 86400
    cookie_name     = ""
    enabled         = false
    type            = "lb_cookie"
  }
  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }
    unhealthy_state_routing {
      minimum_healthy_targets_count      = 1
      minimum_healthy_targets_percentage = "off"
    }
  }
}

resource "aws_iam_role" "service-execution-role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Sid = ""
    }]
    Version = "2012-10-17"
  })
  description           = ""
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "service-execution-09efb7d"
  path                  = "/"
  permissions_boundary  = ""
  tags                  = {}
  tags_all              = {}
}

resource "aws_ecr_repository" "repo" {
  force_delete         = null
  image_tag_mutability = "MUTABLE"
  name                 = "fargate-example/repo"
  region               = "us-east-1"
  tags                 = {}
  tags_all             = {}
  encryption_configuration {
    encryption_type = "AES256"
    kms_key         = ""
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_lb_listener" "loadbalancer-listener" {
  alpn_policy                                                           = null
  certificate_arn                                                       = null
  load_balancer_arn                                                     = "arn:aws:elasticloadbalancing:us-east-1:242040583208:loadbalancer/app/loadbalancer/0387db348ef7779e"
  port                                                                  = 80
  protocol                                                              = "HTTP"
  region                                                                = "us-east-1"
  routing_http_request_x_amzn_mtls_clientcert_header_name               = null
  routing_http_request_x_amzn_mtls_clientcert_issuer_header_name        = null
  routing_http_request_x_amzn_mtls_clientcert_leaf_header_name          = null
  routing_http_request_x_amzn_mtls_clientcert_serial_number_header_name = null
  routing_http_request_x_amzn_mtls_clientcert_subject_header_name       = null
  routing_http_request_x_amzn_mtls_clientcert_validity_header_name      = null
  routing_http_request_x_amzn_tls_cipher_suite_header_name              = null
  routing_http_request_x_amzn_tls_version_header_name                   = null
  routing_http_response_access_control_allow_credentials_header_value   = ""
  routing_http_response_access_control_allow_headers_header_value       = ""
  routing_http_response_access_control_allow_methods_header_value       = ""
  routing_http_response_access_control_allow_origin_header_value        = ""
  routing_http_response_access_control_expose_headers_header_value      = ""
  routing_http_response_access_control_max_age_header_value             = ""
  routing_http_response_content_security_policy_header_value            = ""
  routing_http_response_server_enabled                                  = true
  routing_http_response_strict_transport_security_header_value          = ""
  routing_http_response_x_content_type_options_header_value             = ""
  routing_http_response_x_frame_options_header_value                    = ""
  ssl_policy                                                            = ""
  tags                                                                  = {}
  tags_all                                                              = {}
  tcp_idle_timeout_seconds                                              = null
  default_action {
    order            = 1
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:242040583208:targetgroup/loadbalancer-7d470c7/402581fc31a904eb"
    type             = "forward"
    forward {
      target_group {
        arn    = "arn:aws:elasticloadbalancing:us-east-1:242040583208:targetgroup/loadbalancer-7d470c7/402581fc31a904eb"
        weight = 1
      }
    }
  }
}

resource "aws_security_group" "security-group-1" {
  description = "Managed by Pulumi"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 65535
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  name                   = "loadbalancer-faeb924"
  region                 = "us-east-1"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-8b5ce9f1"
}

resource "aws_lb" "loadbalancer" {
  client_keep_alive                                            = 3600
  customer_owned_ipv4_pool                                     = ""
  desync_mitigation_mode                                       = "defensive"
  dns_record_client_routing_policy                             = null
  drop_invalid_header_fields                                   = false
  enable_cross_zone_load_balancing                             = true
  enable_deletion_protection                                   = false
  enable_http2                                                 = true
  enable_tls_version_and_cipher_suite_headers                  = false
  enable_waf_fail_open                                         = false
  enable_xff_client_port                                       = false
  enable_zonal_shift                                           = false
  idle_timeout                                                 = 60
  internal                                                     = false
  ip_address_type                                              = "ipv4"
  load_balancer_type                                           = "application"
  name                                                         = "loadbalancer"
  preserve_host_header                                         = false
  region                                                       = "us-east-1"
  security_groups                                              = ["sg-06a4066defbdb0a12"]
  subnets                                                      = ["subnet-0224be5e", "subnet-4430a923", "subnet-794b6333", "subnet-a7234489", "subnet-cc1745c3", "subnet-f7d579c9"]
  tags                                                         = {}
  tags_all                                                     = {}
  xff_header_processing_mode                                   = "append"
  access_logs {
    bucket  = ""
    enabled = false
    prefix  = ""
  }
  connection_logs {
    bucket  = ""
    enabled = false
    prefix  = ""
  }
}
