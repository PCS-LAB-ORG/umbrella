output "s3_bucket_id" {
  description = "The name of the tfstate bucket"
  value       = module.remote_state.s3_bucket_id
}
