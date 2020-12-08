Feature: Update Workspace
  In order to update a workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createWorkspace @deleteWorkspace
  Scenario: Verify that is possible to update the workspace information
    When the user sends a PUT request to "/my/workspaces/{id}" with the following Json data
      """
      {
        "project_ids": []
      }
      """
    Then verifies response should have the 200 status code
    And verifies response body should match with "workspaces/messageResponse.json" JSON schema
    And verifies response contain the following values
      | kind | workspace |
      | id   | {id}      |
      | name | {name}    |


  @negative @createWorkspace @deleteWorkspace
  Scenario: Verify that is possible to update the workspace information
    When the user sends a PUT request to "/my/workspaces/{id}" with the following Json data
      """
      {
        "name": "new workspace"
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "workspaces/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code            | invalid_parameter                                      |
      | kind            | error                                                  |
      | error           | One or more request parameters was missing or invalid. |
      | general_problem | this endpoint cannot accept the parameter: name        |

  @negative @createWorkspace @deleteWorkspace
  Scenario: Verify that is not possible to update kind workspace
    When the user sends a PUT request to "/my/workspaces/{id}" with the following Json data
      """
      {
        "kind": "workspace"
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "workspaces/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code            | invalid_parameter                                      |
      | kind            | error                                                  |
      | error           | One or more request parameters was missing or invalid. |
      | general_problem | this endpoint cannot accept the parameter: kind        |

  @negative @createWorkspace @deleteWorkspace
  Scenario: Verify that is not possible to update id of workspace
    When the user sends a PUT request to "/my/workspaces/{id}" with the following Json data
      """
      {
        "id": 2345
      }
      """
    Then verifies response should have the 500 status code
    And verifies response body should match with "workspaces/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code  | api_internal_error                                                                                                                           |
      | kind  | error                                                                                                                                        |
      | error | We encountered an unexpected, unhandleable error while processing your request.  The problem may be transient.  The failure has been logged. |
