terraform {
  backend "s3" {
    bucket   = "homelab"
    key      = "production/tofu.tfstate"
    region   = "auto"
    endpoint = "https://e7ee5ef2f236a9da74f47c10431d23e7.r2.cloudflarestorage.com"

    # Required flags for Cloudflare R2 / S3 API compatibility
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    # use_path_style              = true
  }
}