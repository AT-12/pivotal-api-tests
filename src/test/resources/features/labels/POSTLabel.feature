Feature: POST Labels to a Project
  In order to evaluate the label's of the project
  Authenticated as valid PIVOTAL TRACKER API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createProject @deleteProject
  Scenario Outline: Creates a label in a project
    Given the user sets the following json body
      """
      {
        "name": <name>
      }
      """
    When the user sends a POST request to "/projects/{id}/labels"
    And stores the project id to compare it with returned in body response
    Then verifies response should have the 200 status code
    And verifies response body should match with "labels/messageLabelResponse.json" JSON schema
    And verifies the response contain the following values
      | kind       | label        |
      | project_id | {project_id} |

    Examples:
      | name      |
      | "1234567" |
      | "label1"  |
      | "@#$\#%^" |

  @negative @createProject @deleteProject
  Scenario: Verify cannot create a label with null name in a project
    When the user sends a POST request to "/projects/{id}/labels" with the following Json data
      """
      {
        "name": null
      }
      """
    Then verifies response should have the 400 status code
    And verifies response body should match with "labels/errorLabelNameResponse.json" JSON schema
    And verifies response should contain the following values
      | code                         | invalid_parameter                                      |
      | kind                         | error                                                  |
      | error                        | One or more request parameters was missing or invalid. |
      | validation_errors[0].field   | name                                                   |
      | validation_errors[0].problem | Please enter a name for the label.                     |

  @negative
  Scenario: Verify not information is returned when invalid project id is provided
    When the user stores an invalid value as "project id" in workspace
    And sends a POST request to "/projects/{id}/labels" with the following Json data
      """
      {
        "name": "a new hope"
      }
      """
    Then verifies response should have the 404 status code
    And verifies response body should match with "labels/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | code  | unfound_resource                                                                                                                                                                                                          |
      | kind  | error                                                                                                                                                                                                                     |
      | error | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree. |

  @negative @createProject @deleteProject
  Scenario: Verify cannot create a label in a project with quotation marks in the name
    When the user sends a POST request to "/projects/{id}/labels" with the following Json data
      """
      {
        "name": "@#"$#%^"
      }
      """
    Then verifies response should have the 500 status code
    And verifies response body should match with "labels/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | code  | unhandled_condition               |
      | kind  | error                             |
      | error | An unexpected condition occurred. |

  @functional @createProject @createStory @createStoryLabel @deleteProject
  Scenario: Verify that label created is returned
    When sends a POST request to "/projects/{project_id}/stories/{story_id}/labels" with the following Json data
      """
      {
        "name": "my new label"
      }
      """
    Then verifies response should have the 200 status code
    And verifies response body should match with "labels/messageLabelResponse.json" JSON schema
    And verifies the response contain the following values
      | kind       | label        |
      | id         | {id}         |
      | project_id | {project_id} |
      | name       | my new label |