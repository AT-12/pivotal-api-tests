Feature: Get Project
  In order to get a project in Pivotal
  Authenticated as valid Pivotal API consumer

  Background: Set authentication
    Given the user sets valid authentication to request

  @functional @createProject @deleteProject
  Scenario: Verify it returns an existing project
    When the user sends a GET request to "/projects/{id}"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectGetResponse.json" JSON schema
    And verifies response contain the following values
      | id               | {id}    |
      | name             | {name}          |
      | kind             | project         |
      | version          | 1               |
      | iteration_length | 1               |

  @setAndIdFromADifferentProject
  Scenario: Verify not information is returned when accessing to project id from a different account
    When the user sends an invalid id to GET request to "/projects/{id}"
    Then  verifies response should have the 403 status code
    And verifies response body should match with "projects/projectNotAuthorizedResponse.json" JSON schema
    And verifies response contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |

  @setInvalidProject
  Scenario: Verify not information is returned when accessing to an unexisting project id
    When the user sends an invalid id to GET request to "/projects/{id}"
    Then  verifies response should have the 404 status code
    And verifies response body should match with "projects/projectNotFoundIdProjectResponse.json" JSON schema
    And verifies response contain the following values
      | code              | unfound_resource                                        |
      | kind              | error                                                   |
      | error             | The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree.                                  |


  @createProject @deleteProject
  Scenario: Verify it returns a not found when sending an invalid route
    When the user sends an invalid endpoint to GET request to "/project/{id}"
    Then  verifies response should have the 404 status code
    And verifies response body should match with "projects/projectNoExistingEndpoint.json" JSON schema
    And verifies response contain the following values
      | code              | route_not_found                                         |
      | kind              | error                                                   |
      | error             | The path you requested has no valid endpoint.           |

  @deleteAllProjects
  Scenario: Verify if the response is empty when no projects found
    When the user sends a GET request to "/projects/"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectEmptyJsonResponse.json" JSON schema

