# pivotal-api-tests
Pivotal Tracker API tests

[![Build Status](https://travis-ci.com/AT-12/pivotal-api-tests.svg?branch=develop)](https://travis-ci.com/AT-12/pivotal-api-tests) 

[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=AT-12_pivotal-api-tests&metric=alert_status)](https://sonarcloud.io/dashboard/index/AT-12_pivotal-api-tests)
# Description
This is the AT-12's project, it was made on API Testing subject. 
The proposal of this project is to implement Web API testing applying BDD with Gherkin.  
# Environment setup
Create an account on https://www.pivotaltracker.com/ and set the following variables on gradle.properties.
- set baseUrl = https://www.pivotaltracker.com/services/v5
- set token = (your token)
- set schemasPath = src/test/resources/schemas/
- set filterTags = 
- set cucumberThreadCount = (the number of threads)

# Execute tests
In order to execute the tests there are the followings commands:

- ./gradlew clean check
- ./gradlew clean test
- ./gradlew clean executeBDDTests
- ./gradlew reExecuteBDDTests
# Endpoints tested
The endpoints tested are:
- **/projects**
    - POST 
        - /projects
    - GET 
        - /projects
        - /projects/{project_id}
    - DELETE 
        - /projects/{project_id}
    - PUT
        - /projects/{project_id}
- **/workspaces**
    - POST 
        - /my/workspaces
    - GET 
        - /my/workspaces
        - /my/workspaces/{workspace_id}
    - DELETE 
        - /my/workspaces/{workspace_id}
    - PUT
        - /my/workspaces/{workspace_id}
- **/labels**
    - POST 
        - /projects/{project_id}/labels
        - /projects/{project_id}/stories/{story_id}/labels
    - GET 
        - /projects/{project_id}/labels
        - /projects/{project_id}/labels/{label_id}
        - /projects/{project_id}/stories/{story_id}/labels
    - DELETE 
        - /projects/{project_id}/labels/{label_id}
        - /projects/{project_id}/stories/{story_id}/labels/{label_id}
    - PUT
        - /projects/{project_id}/labels/{label_id}
        
