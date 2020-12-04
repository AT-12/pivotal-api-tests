Feature: Update Workspace
  In order to update a workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional
  Scenario: Verify that is possible to update the workspace information
    When the user sends a PUT request to "/my/workspaces/{workspace_id}" with the following Json data
      """
      {
        "project_ids": []
      }
      """
    Then verifies response should have the 200 status code
    And verifies response body should match with "common/messageResponse.json" JSON schema
    And verifies response contain the following values
      | status | 200 |
