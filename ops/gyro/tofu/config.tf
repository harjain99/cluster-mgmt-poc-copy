terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "psd-beam-sandbox"
}

import {
  to = aws_ecs_cluster.cluster
  id = "cluster"
}

import {
  to = aws_lb_target_group.target-group
  id = "arn:aws:elasticloadbalancing:us-east-1:242040583208:targetgroup/loadbalancer-7d470c7/402581fc31a904eb"
}

import {
  to = aws_security_group.security-group-1
  id = "sg-06a4066defbdb0a12"
}

import {
  to = aws_lb.loadbalancer
  id = "arn:aws:elasticloadbalancing:us-east-1:242040583208:loadbalancer/app/loadbalancer/0387db348ef7779e"
}

import {
  to = aws_lb_listener.loadbalancer-listener
  id = "arn:aws:elasticloadbalancing:us-east-1:242040583208:listener/app/loadbalancer/0387db348ef7779e/6d6a1b2a4300490e"
}

import {
  to = aws_ecr_repository.repo
  id = "fargate-example/repo"
}

import {
  to = aws_ecr_lifecycle_policy.repo-lifecycle-policy
  id = "fargate-example/repo"
}

import {
  to = aws_cloudwatch_log_group.log-group
  id = "service-46e9080"
}

import {
  to = aws_ecs_task_definition.task-definition
  id = "arn:aws:ecs:us-east-1:242040583208:task-definition/service-6c6e6c22:3"
}

import {
  to = aws_ecs_service.service
  id = "cluster/service"
}

import {
  to = aws_iam_role.service-execution-role
  id = "service-execution-09efb7d"
}

import {
  to = aws_iam_role_policy_attachment.service-execution-role-policy-attachment
  id = "service-execution-09efb7d/arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

import {
  to = aws_security_group.security-group-2
  id = "sg-073147b625fb7e43d"
}

import {
  to = aws_iam_role.task-role
  id = "taskRole-bd0c737"
}

import {
  to = aws_iam_role_policy_attachment.task-role-policy-attachment
  id = "taskRole-bd0c737/arn:aws:iam::aws:policy/AdministratorAccess"
}
