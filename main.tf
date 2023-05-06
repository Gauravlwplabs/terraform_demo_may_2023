resource "aws_instance" "this" {
  ami             = "ami-0889a44b331db0194"
  instance_type   = "t2.large"
  key_name        = var.key_name
  user_data       = file("${path.module}/install.sh")
  security_groups = ["${aws_security_group.this.name}"]
  tags = {
    Name = "${var.name}"
  }
}
resource "aws_s3_bucket" "this" {
  bucket_prefix = "my-lwp-bucket-2021"

  tags = {
    Name        = "my_bucket"
    Environment = var.env
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]

  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
resource "aws_security_group" "this" {
  name        = "http-sg"
  description = "Allow traffic for http"
  vpc_id      = var.vpc_name
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}
