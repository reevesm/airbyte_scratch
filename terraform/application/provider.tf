terraform {
  required_providers {
    airbyte = {
      source = "airbytehq/airbyte"
      version = "0.3.4"
    }
  }
}

provider "airbyte" {
  // If running on Airbyte Cloud,
  // generate & save your API key from https://portal.airbyte.com
  // bearer_auth = var.api_key

  // If running locally (Airbyte OSS) with docker-compose using the airbyte-proxy,
  // include the actual password/username you've set up (or use the defaults below)
  username = "airbyte"
  password = "password"

  // if running locally (Airbyte OSS), include the server url to the airbyte-api-server
  server_url = "http://localhost:8006/v1/" // (and UI is at http://airbyte.company.com:8000)
}
