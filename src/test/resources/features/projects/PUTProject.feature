Feature: Put Project
  In order to put a project in Pivotal
  Authenticated as valid Pivotal API consumer

  Background: Set authentication
    Given the user sets valid authentication to request

  @functional @createProject @deleteProject
  Scenario: Verify if it updates an existing project
    Given the following values in the Json data
    """
    {
      "name": "project_updated"
    }
    """
    When the user sends PUT request to "/projects/{id}"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectSuccessUpdateResponse.json" JSON schema
    And verifies response contain the following values
      | id                 | {id}    |
      | kind               | project         |
      | name               | project_updated |
      | version            | 2               |
      | iteration_length   | 1               |

  @negative @createProject @deleteProject
  Scenario: Verify not updating when sending a null name
    Given the following values in the Json data
    """
    {
      "name": null
    }
    """
    When the user sends PUT request to "/projects/{id}"
    Then  verifies response should have the 400 status code
    And verifies response body should match with "projects/projectInvalidParameterResponse.json" JSON schema
    And verifies response contain the following values
      | code                          | invalid_parameter     |
      | kind                          | error                 |
      | general_problem               | Name can't be blank   |
      | validation_errors[0].field    | name                   |
      | validation_errors[0].problem  | Name can't be blank    |


  @negative @setAndIdFromADifferentProject
  Scenario: Verify not updating when sending a project id from a different account
    When the user sends PUT request to "/projects/{id}"
    Then  verifies response should have the 403 status code
    And verifies response body should match with "projects/projectNotAuthorizedResponse.json" JSON schema
    And verifies response contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |

  @negative @setInvalidProject
  Scenario: Verify not updating when sending an unexisting project
    When the user sends PUT request to "/projects/{id}"
    Then  verifies response should have the 404 status code
    And verifies response body should match with "projects/projectNotFoundIdProjectResponse.json" JSON schema
    And verifies response contain the following values
      | code              | unfound_resource                                        |
      | kind              | error                                                   |
      | error             | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree.          |

