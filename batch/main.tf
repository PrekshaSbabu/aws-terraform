resource "aws_batch_compute_environment" "test-batch-compute" {
  compute_environment_name = "dev_environment"
  type                     = "MANAGED"
  state                    = "ENABLED"

  compute_resources {
    type = "FARGATE"
    minv_cpus = 0
    maxv_cpus = 3
    subnets = ["subnet-0650c420ce853e926"] # Specify your subnet IDs
    security_group_ids = aws_security_group.batch-security-group.id # Specify your security group IDs
  }
}

resource "aws_batch_job_queue" "test-batch_job_queue" {
  name = "dev_job_queue"
  state = "ENABLED"
  priority = 1

  compute_environments = [aws_batch_compute_environment.test-batch-compute.name]
}

resource "aws_batch_job_definition" "test-batch_job_definition" {
  name = "dev_job_definition"
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
  "image": "your_container_image",
  "vcpus": 1,
  "memory": 2048,
  "command": ["your_command"],
  "jobRoleArn": "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
}
CONTAINER_PROPERTIES
}

resource "aws_batch_job" "fargate_job" {
  name        = "fargate_job"
  job_queue   = aws_batch_job_queue.fargate_job_queue.arn
  job_definition = aws_batch_job_definition.fargate_job_definition.arn
  depends_on = [aws_batch_job_definition.fargate_job_definition]
}