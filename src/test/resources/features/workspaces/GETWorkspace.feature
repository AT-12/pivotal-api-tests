Feature: GET Workspace
  In order to read workspace in pivotal
  Authenticated as valid Pivotal API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @smokeTest @createWorkspace @deleteWorkspace
  Scenario: Verify that is possible to retrieve all workspaces as list
    When the user sends a GET request to "/my/workspaces"
    Then verifies response should have the 200 status code
    And verifies response body should match with "workspaces/listResponse.json" JSON schema
    And verifies the response contain the following values
      | [0].kind | workspace |
      | [0].id   | {id0}      |
      | [0].name | {name0}    |

  @functional @createWorkspace @deleteWorkspace
  Scenario: Verify that is possible to retrieve a workspace
    When the user sends a GET request to "/my/workspaces/{id}"
    Then verifies response should have the 200 status code
    And verifies response body should match with "workspaces/messageResponse.json" JSON schema
    And verifies the response contain the following values
      | kind | workspace |
      | id   | {id}      |
      | name | {name}    |

  @negative
  Scenario: Verify not information is returned when invalid workspace id is provided
    When the user sends a GET request to "/my/workspaces/234"
    Then verifies response should have the 403 status code
    And verifies response body should match with "workspaces/errorResponse.json" JSON schema
    And verifies response contain the following values
      | code              | unauthorized_operation                                  |
      | kind              | error                                                   |
      | error             | Authorization failure.                                  |
      | general_problem   | You aren't authorized to access the requested resource. |

  @functional
  Scenario: Verify that it returns empty list if workspace does not exist
    When the user sends a GET request to "/my/workspaces"
    Then  verifies response should have the 200 status code
    And verifies response body should match with "workspaces/emptyResponse.json" JSON schema