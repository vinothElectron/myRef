provider "github" {
  token = "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"
}
resource "github_repository" "example" {
  name        = "example"
  description = "test terraform"
  visibility  = "public"
}
