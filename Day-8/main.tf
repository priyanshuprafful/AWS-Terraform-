#create s3 bucket
resource "aws_s3_bucket" "my_bucket1" {  
    bucket = "my-unique-bucket-prafful-123456"  

    tags = var.tags
    
    }