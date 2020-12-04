Feature: Delete Workspace
  In order to update a workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createWorkspace
  Scenario: Verify that is possible to delete a workspace
    When the user sends a DELETE request to "/my/workspaces/{workspace_id}"
    Then verifies response should have the 204 status code

  @negative
  Scenario: Verify that isn't possible to update a workspace non-existent
    When the user sends a DELETE request to "/my/workspaces/1"
    Then verifies response should have the 404 status code
    And verifies response body should match with "workspace/errorResponse.json" JSON schema
    And verifies response contain the following values
      | kind | error|