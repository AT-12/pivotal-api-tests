Feature: Delete Workspace
  In order to update a workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createWorkspace
  Scenario: Verify that is possible to delete a workspace
    When the user sends a DELETE request to "/my/workspaces/{id}"
    Then verifies response should have the 204 status code

  @negative
  Scenario: Verify that isn't possible to delete a workspace non-existent
    When the user sends a DELETE request to "/my/workspaces/1"
    Then verifies response should have the 404 status code
    And verifies response body should match with "workspaces/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code  | unfound_resource                                                                                                                                                                                                          |
      | kind  | error                                                                                                                                                                                                                     |
      | error | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree. |

  @negative @createWorkspace
  Scenario: Verify that isn't possible to delete all workspaces
    When the user sends a DELETE request to "/my/workspaces"
    Then verifies response should have the 404 status code
    And verifies response body should match with "workspaces/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code  | route_not_found                               |
      | kind  | error                                         |
      | error | The path you requested has no valid endpoint. |