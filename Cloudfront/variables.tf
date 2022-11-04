variable "bucket_name" {
    type = string
    description = "Name of the S3 bucket"
}

variable "acl" {
    type = string
    description = "Should acl be private or not"
}
variable "cache_policy" {
    type = string
    description = "Name of the cache policy"
}

variable "policy_comment" {
    type = string
    description = "Comment regarding the policy"
  
}

variable "s3_origin_id" {
  description = "Origin Id "
}