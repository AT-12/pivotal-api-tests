Feature: Create Workspace
  In order to create a workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @deleteWorkspace
  Scenario: Verify workspace is created with the minimum required parameters
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "my first workspace"
      }
      """
    Then verifies response should have the "200" status code
    And verifies response body should match with "common/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind        | workspace          |
      | name        | my first workspace |


  @functional @deleteWorkspace
  Scenario: Verify workspace is created with special characters
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "_"
      }
      """
    Then verifies response should have the "200" status code
    And verifies response body should match with "common/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind        | workspace          |
      | name        | _                  |

  @functional @createProject
  Scenario: Verify that is possible to create a workspace with project ids
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "my first workspace",
        "project_ids":[{project_id}]
      }
      """
    Then verifies response should have the "200" status code
    And verifies response body should match with "common/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind        | workspace          |
      | name        | my first workspace |
      | project_ids | [99,98]            |


  @negative
  Scenario: Verify that isn't possible to create a workspace with more than 25 characters
    When The user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "my first workspace workspace workspace"
      }
      """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response contain the following values
      | status | 400 |
      | error  |One or more request parameters was missing or invalid.|

  @negative
  Scenario: Verify that isn't possible to create a workspace with with empty values
    When The user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": ""
      }
      """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response contain the following values
      | status | 400 |
      | error  |One or more request parameters was missing or invalid.|