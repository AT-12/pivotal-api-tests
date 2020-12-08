Feature: Labels of Stories
  In order to evaluate the story's labels of a project
  Authenticated as valid PIVOTAL TRACKER API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createProject @createLabel @deleteProject
  Scenario: Verify that label is removed from the story
    When sends a DELETE request to "/projects/{project_id}/labels/{id}"
    Then verifies response should have the 204 status code

  @negative @createProject @createLabel @deleteProject
  Scenario: Verify cannot delete a label when invalid project id is provided
    When the user stores an invalid value as "project id" in workspace
    And sends a DELETE request to "/projects/{project_id}/labels/{id}"
    Then verifies response should have the 404 status code
    And verifies response body should match with "labels/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code  | unfound_resource                                                                                                                                                                                                          |
      | kind  | error                                                                                                                                                                                                                     |
      | error | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree. |

  @negative @createProject @createLabel @deleteProject
  Scenario: Verify cannot update a label when invalid label id is provided
    When the user stores an invalid value as "label id" in workspace
    And sends a DELETE request to "/projects/{project_id}/labels/{id}"
    Then verifies response should have the 400 status code
    And verifies response body should match with "labels/errorLabelResponse.json" JSON schema
    And verifies response contain the following values
      | code            | invalid_parameter                                                             |
      | kind            | error                                                                         |
      | error           | One or more request parameters was missing or invalid.                        |
      | general_problem | No label found to delete.                                                     |
      | possible_fix    | The label could have already been moved or deleted, or is in another project. |
