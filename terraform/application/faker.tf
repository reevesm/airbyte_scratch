# workspace
resource "airbyte_workspace" "test_workspace" {
  name = "Test Workspace"
}

# source
resource "airbyte_source_faker" "test_source_faker" {
  configuration = {
    always_updated = true
    count = 1000
    parallelism = 1
    records_per_slice = 10
    seed = -1
    source_type = "faker"
  }

  name = "Test Source"
  workspace_id = airbyte_workspace.test_workspace.workspace_id
}

# dest
resource "airbyte_destination_postgres" "test_destination_postgres" {
  configuration = {
    database         = "airbyte_faker"
    destination_type = "postgres"
    host             = "db"
    jdbc_url_params  = ""
    password         = "docker"
    port             = 5432
    schema           = "public"
    ssl_mode = {
      destination_postgres_ssl_modes_allow = {
        mode = "allow"
      }
    }
    username = "docker"
  }
  name         = "Test Destination"
  workspace_id = airbyte_workspace.test_workspace.workspace_id
}

# connection
resource "airbyte_connection" "test_connection" {
  name            = "Test Connection"
  source_id       = airbyte_source_faker.test_source_faker.source_id
  destination_id  = airbyte_destination_postgres.test_destination_postgres.destination_id
  configurations  = {
    streams = [
      {
        "name": "products",
        "destination_sync_mode": "upsert"
      }
    ]
  }
}