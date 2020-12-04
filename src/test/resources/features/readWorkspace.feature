Feature: Read Workspace
  In order to read workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional
  Scenario: Verify that is possible to retrieve all workspaces as list
    When the user sends a GET request to "/my/workspaces"
    Then verifies response should have the 200 status code
    And verifies response contain the following values
      | status | 200 |

  @functional
  Scenario: Verify that is possible to retrieve a workspace
    When the user sends a GET request to "/my/workspaces/{workspace_id}"
    Then verifies response should have the 200 status code
    And verifies response contain the following values
      | status | 200 |