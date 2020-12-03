Feature: Get Project
  In order to get a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given the user sets valid authentication to request
  @functional
  Scenario: Verify board is created with minimum required parameters
    When the user sends a GET request to "/projects/{project_id}" with the following Json data
      """
      {
        "token":"f8f84dde38f41e1da423fd7f35e75caf"
      }
      """
    Then  the response should return the "200" status code
    And verifies response body should match with "common/projectGetResponse.json" JSON schema
    And verifies response should contain the following values
      | status | 200 |

Feature: Update Project
  In order to update a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given the user sets valid authentication to request
  @functional
  Scenario: Verify board is created with minimum required parameters
    When the user sends a PUT request to "/projects/{project_id}" with the following Json data
      """
      {
        "token":"f8f84dde38f41e1da423fd7f35e75caf"
        "name":"Project-test"
      }
      """
    Then  the response should return the "200" status code
    And verifies response body should match with "common/projectUpdateResponse.json" JSON schema
    And verifies response should contain the following values
      | status | 200 |


Feature: Delete Project
  In order to delete a project in Pivotal
  Authenticated as valid Pivotal API consumer
  Background: Set authentication
    Given the user sets valid authentication to request
  @functional
  Scenario: Verify board is created with minimum required parameters
    When the user sends a DELETE request to "/projects/{project_id}" with the following Json data
      """
      {
        "token":"f8f84dde38f41e1da423fd7f35e75caf"
      }
      """
    Then  the response should return the "204" status code
    And verifies response body should match with "common/projectDeleteResponse.json" JSON schema
    And verifies response should contain the following values
      | status | 204 |