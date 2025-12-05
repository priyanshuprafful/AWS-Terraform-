#create s3 bucket
resource "aws_s3_bucket" "my_bucket1" {  
    count = length(var.bucket_names)
    bucket = var.bucket_names[count.index]

    tags = var.tags
    
}