Feature: Get Project
  In order to get a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given The user sets valid authentication to request

  @functional @createProject @deleteProject
  Scenario: Verify it returns an existing project
    When the user sends a GET request to "/projects/{project_id}"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectGetResponse.json" JSON schema
    And verifies response should contain the following values
      | id               | {project_id}    |
      | name             | {name}          |
      | kind             | project         |
      | version          | 1               |
      | iteration_length | 1               |

  @setInvalidProject
  Scenario: Verify it throws an exception when sending an invalid id
    When the user sends an invalid id to GET request to "/projects/{project_id}"
    Then  verifies response should have the 403 status code
    And verifies response body should match with "projects/projectErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |

  @createProject @deleteProject
  Scenario: Verify it throws an exception when sending a valid id but invalid endpoint
    When the user sends an invalid endpoint to GET request to "/project/{project_id}"
    Then  verifies response should have the 404 status code
    And verifies response body should match with "projects/projectNoExistingEndpoint.json" JSON schema
    And verifies response should contain the following values
      | code              | route_not_found                                         |
      | kind              | error                                                   |
      | error             | The path you requested has no valid endpoint.           |

  @deleteAllProjects
  Scenario: Verify it returns an empty array when there's no projects
    When the user sends a GET request to "/projects/"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectEmptyJsonResponse.json" JSON schema

