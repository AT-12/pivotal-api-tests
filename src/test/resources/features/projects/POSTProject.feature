Feature: Post Project
  In order to post a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given The user sets valid authentication to request

  @functional @deleteProject
  Scenario: Verify if it creates a new project
    Given the following values in the Json data
    """
    {
      "name": "pre-demo"
    }
    """
    When the user sends a POST request to "/projects"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "projects/projectSuccessCreatedProjectResponse.json" JSON schema
    And verifies response should contain the following values
      | id                 | {project_id}    |
      | kind               | project         |
      | name               | pre-demo        |
      | version            | 1               |
      | iteration_length   | 1               |
