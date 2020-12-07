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
    And stores workspace id to clean workspace
    Then verifies response should have the 200 status code
    And verifies response body should match with "workspace/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind        | workspace          |
      | name        | my first workspace |


  @functional @deleteWorkspace
  Scenario: Verify workspace is created with special characters
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "%_"
      }
      """
    And stores workspace id to clean workspace
    Then verifies response should have the 200 status code
    And verifies response body should match with "workspace/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind        | workspace          |
      | name        | %_                 |

  @functional @createProject @deleteProject @deleteWorkspace
  Scenario: Verify that is possible to create a workspace with project ids
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "my second workspace",
        "project_ids":[{id}]
      }
      """
    And stores workspace id to clean workspace
    Then verifies response should have the 200 status code
    And verifies response body should match with "workspace/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind        | workspace           |
      | name        | my second workspace |


  @negative
  Scenario: Verify that isn't possible to create a workspace with more than 25 characters
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": "my first workspace workspace workspace"
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "workspace/errorResponse.json" JSON schema
    And verifies response contain the following values
      | kind   | error |
      | error  | One or more request parameters was missing or invalid.|

  @negative
  Scenario: Verify that isn't possible to create a workspace with with empty values
    When the user sends a POST request to "/my/workspaces" with the following Json data
      """
      {
        "name": ""
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "workspace/errorResponse.json" JSON schema
    And verifies response contain the following values
      | kind   | error |
      | error  | One or more request parameters was missing or invalid.|