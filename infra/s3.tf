resource "aws_s3_bucket" "bucket_workshop_24" {
  bucket = "workshop-24-${var.managed_by}-2025"
  tags = {
    Name = "${var.workshop_edition}"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_workshop_24.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        // New policy statement to add
        Sid    = "AllowEC2"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = ["s3:*"]
        Resource = [
          "${aws_s3_bucket.bucket_workshop_24.arn}/*",
        ]
      }
    ]
  })
}