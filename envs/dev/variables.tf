variable "db_password" {
  description = "Master password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
  default     = "kkp12345678"

}

variable "jwt_secret" {
  description = "JWT signing secret for the application"
  type        = string
  sensitive   = true
  default     = "kkp12345678"
}

variable "github_org" {
  description = "GitHub username or organization that owns frontend and backend"
  type        = string
  default     = "srpaul2091"
}