Feature: Delete Project
  In order to delete a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given The user sets valid authentication to request

  @functional @createProject
  Scenario: Verify if it deletes an existing project
    When the user sends a DELETE request to "/projects/{project_id}"
    Then  verifies response should have the 204 status code

  @negative @setAndIdFromADifferentProject
  Scenario: Verify not project deletion using a project id from a different account
    When the user sends a DELETE request to "/projects/{project_id}"
    Then  verifies response should have the 403 status code
    And verifies response body should match with "projects/projectNotAuthorizedResponse.json" JSON schema
    And verifies response should contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |

  @negative @setInvalidProject
  Scenario: Verify not project deletion using an unexisting id project
    When the user sends a DELETE request to "/projects/{project_id}"
    Then  verifies response should have the 404 status code
    And verifies response body should match with "projects/projectNotFoundIdProjectResponse.json" JSON schema
    And verifies response should contain the following values
      | code              | unfound_resource                                        |
      | kind              | error                                                   |
      | error             | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree.                                  |

