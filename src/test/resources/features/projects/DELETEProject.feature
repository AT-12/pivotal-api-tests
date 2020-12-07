Feature: Delete Project
  In order to delete a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given The user sets valid authentication to request

  @functional @createProject
  Scenario: Verify if it deletes an existing project
    When the user sends a DELETE request to "/projects/{project_id}"
    Then  verifies response should have the 204 status code

  @negative @setInvalidProject
  Scenario: Verify if it deletes an existing project
    When the user sends a DELETE request to "/projects/{project_id}"
    Then  verifies response should have the 403 status code
    And verifies response body should match with "projects/projectErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |
