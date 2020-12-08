Feature: GET Labels of a Project
  In order to evaluate the label's of the project
  Authenticated as valid PIVOTAL TRACKER API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createProject @createLabel @deleteProject
  Scenario: Verify the project's label is returned
    When the user sends a GET request to "/projects/{project_id}/labels"
    Then verifies response should have the 200 status code
    And verifies response body should match with "labels/messageResponse.json" JSON schema
    And verifies the response contain the following values
      | [0].kind | label  |
      | [0].name | {name} |

  @functional @createProject @createLabels @deleteProject
  Scenario: Verify all project's labels are returned
    When the user sends a GET request to "/projects/{project_id}/labels"
    Then verifies response should have the 200 status code
    And verifies response body should match with "labels/messageLabelsResponse.json" JSON schema
    And verifies the response contain the following values
      | [0].kind       | label        |
      | [0].id         | {id0}        |
      | [0].project_id | {project_id} |
      | [1].kind       | label        |
      | [1].id         | {id1}        |

  @functional @createProject @createLabel @deleteProject
  Scenario: Verify the project's label required is returned
    When the user sends a GET request to "/projects/{project_id}/labels/{id}"
    Then verifies response should have the 200 status code
    And verifies response body should match with "labels/createLabelResponse.json" JSON schema
    And verifies the response contain the following values
      | kind | label  |
      | id   | {id}   |
      | name | {name} |

  @negative @createProject @createLabel @deleteProject
  Scenario: Verify not information is returned when invalid label id is provided
    When the user stores an invalid value as "label id" in workspace
    And sends a GET request to "/projects/{project_id}/labels/{id}"
    Then verifies response should have the 404 status code
    And verifies response body should match with "labels/errorUnfoundResource.json" JSON schema
    And verifies the response contain the following values
      | code  | unfound_resource                                                                                                                                                                                                          |
      | kind  | error                                                                                                                                                                                                                     |
      | error | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree. |

  @negative
  Scenario: Verify not information is returned when invalid project id is provided
    When the user stores an invalid value as "project id" in workspace
    And sends a GET request to "/projects/{id}/labels"
    Then verifies response should have the 404 status code
    And verifies response body should match with "labels/errorUnfoundResource.json" JSON schema
    And verifies response should contain the following values
      | code  | unfound_resource                                                                                                                                                                                                          |
      | kind  | error                                                                                                                                                                                                                     |
      | error | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree. |
