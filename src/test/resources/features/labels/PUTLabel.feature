Feature: GET Labels of a Project
  In order to evaluate the label's of the project
  Authenticated as valid PIVOTAL TRACKER API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createProject @createStory @createStoryLabel @deleteProject
  Scenario Outline: Updates a label in a project
    Given the user sets the following json body
      """
      {
        "name": <name>
      }
      """
    When sends a PUT request to "/projects/{project_id}/labels/{id}"
    Then verifies response should have the 200 status code
    And verifies response body should match with "labels/createLabelResponse.json" JSON schema
    And verifies the response contain the following values
      | kind       | label        |
      | id         | {id}         |
      | project_id | {project_id} |
      | name       | {name}       |

    Examples:
      | name                   |
      | "diplomatic relations" |
      | "SECURITY"             |
      | "123654879"            |
      | "@#$\#%^"              |

  @functional @createProject @createLabels @deleteProject
  Scenario: Verify cannot update a label with null name in a project
    When the user sends a PUT request to "/projects/{project_id}/labels/{id}" with the following Json data
      """
      {
        "name": null
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "labels/invalidLabel.json" JSON schema
    And verifies response should contain the following values
      | code                         | invalid_parameter                                      |
      | kind                         | error                                                  |
      | error                        | One or more request parameters was missing or invalid. |
      | validation_errors[0].field   | name                                                   |
      | validation_errors[0].problem | Please enter a name for the label.                     |

  @negative @createProject @createLabel @deleteProject
  Scenario: Verify cannot update a label when invalid project id is provided
    When the user stores an invalid value as "project id" in workspace
    And sends a PUT request to "/projects/{project_id}/labels/{id}" with the following Json data
      """
      {
        "name": "security"
      }
      """
    Then verifies response should have the 404 status code
    And verifies response body should match with "labels/errorUnfoundResource.json" JSON schema
    And verifies response should contain the following values
      | code  | unfound_resource                                                                                                                                                                                                          |
      | kind  | error                                                                                                                                                                                                                     |
      | error | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree. |

  @negative @createProject @createLabel @deleteProject
  Scenario: Verify cannot update a label when invalid label id is provided
    When the user stores an invalid value as "label id" in workspace
    And sends a PUT request to "/projects/{project_id}/labels/{id}" with the following Json data
      """
      {
        "name": "security"
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "labels/invalidLabelId.json" JSON schema
    And verifies response should contain the following values
      | code            | invalid_parameter                                                             |
      | kind            | error                                                                         |
      | error           | One or more request parameters was missing or invalid.                        |
      | general_problem | No label found to update.                                                     |
      | possible_fix    | The label could have already been moved or deleted, or is in another project. |
