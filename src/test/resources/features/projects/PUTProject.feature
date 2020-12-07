Feature: Put Project
  In order to put a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given The user sets valid authentication to request

  @functional @createProject @deleteProject
  Scenario: Verify if it updates an existing project
    Given the following values in the Json data
    """
    {
      "name": "project_updated"
    }
    """
    When the user sends a PUT request to "/projects/{project_id}"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectSuccessUpdateResponse.json" JSON schema
    And verifies response should contain the following values
      | id                 | {project_id}    |
      | kind               | project         |
      | name               | project_updated |
      | version            | 2               |
      | iteration_length   | 1               |

  @negative @createProject @deleteProject
  Scenario: Verify if it throws an exception sending an invalid name
    Given the following values in the Json data
    """
    {
      "name": ""
    }
    """
    When the user sends a PUT request to "/projects/{project_id}"
    Then  verifies response should have the 500 status code
    And verifies response body should match with "projects/projectInvalidParameterResponse.json" JSON schema
    And verifies response should contain the following values
      | code                          | invalid_parameter     |
      | kind                          | error                 |
      | general_problem               | Name can't be blank   |
      | validation_errors[0].field    | name                   |
      | validation_errors[0].problem  | Name can't be blank    |


  @negative @setInvalidProject
  Scenario: Verify if it throws an exception sending an unexisting project
    When the user sends a PUT request to "/projects/{project_id}"
    Then  verifies response should have the 403 status code
    And verifies response body should match with "projects/projectErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |


