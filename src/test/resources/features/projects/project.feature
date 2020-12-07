Feature: Get Project
  In order to get a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given The user sets valid authentication to request
  @functional @createProject @deleteProject
  Scenario: Verify project is created with minimum required parameters
    When the user sends a GET request to "/projects/{project_id}"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "common/projectGetResponse.json" JSON schema
    And verifies response should contain the following values
      | status | 200 |
