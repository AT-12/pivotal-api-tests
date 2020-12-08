package org.fundacionjala.pivotal.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.core.utils.JsonSchemaValidator;
import org.fundacionjala.core.utils.Mapper;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;
import org.fundacionjala.pivotal.utils.ResponseBodyValidator;
import org.testng.Assert;

import java.io.IOException;
import java.util.Map;

public class RequestStepDefs {

    private Response response;
    private Context context;
    private String projectId = "";
    private String valuesMapped = "";

    /**
     * Constructor of Request Step Definitions.
     *
     * @param contextToSet Context to set
     */
    public RequestStepDefs(final Context contextToSet) {
        this.context = contextToSet;
    }

    /**
     * Sets valid authentication headers.
     */
    @Given("the user sets valid authentication to request")
    public void setsValidAuthentication() {
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
    }

    /**
     * Sends a GET request.
     *
     * @param endpoint resource endpoint
     */
    @When("the user sends a GET request to {string}")
    @And("sends a GET request to {string}")
    public void sendsGETRequest(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.get(endpointMapped);
    }

    /**
     * Sends a POST request.
     *
     * @param endpoint resource endpoint
     */
    @When("the user sends a POST request to {string}")
    public void sendsPOSTRequest(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.post(endpointMapped, valuesMapped);
    }

    /**
     * Sends a POST request with body.
     *
     * @param endpoint resource endpoint
     * @param body json data
     */
    @When("the user sends a POST request to {string} with the following Json data")
    @And("sends a POST request to {string} with the following Json data")
    public void sendsPOSTRequest(final String endpoint, final String body) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        String bodyMapped = Mapper.mapValue(body, context.getData());
        response = RequestManager.post(endpointMapped, bodyMapped);
    }

    /**
     * Sends a PUT request.
     *
     * @param endpoint resource endpoint
     */
    @When("sends a PUT request to {string}")
    public void sendsPUTRequest(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.put(endpointMapped, valuesMapped);
    }

    /**
     * Sends a PUT request with body.
     *
     * @param endpoint resource endpoint
     * @param body json data
     */
    @When("the user sends a PUT request to {string} with the following Json data")
    @And("sends a PUT request to {string} with the following Json data")
    public void sendsPUTRequest(final String endpoint, final String body) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.put(endpointMapped, body);
    }

    /**
     * Sends a DELETE request.
     *
     * @param endpoint resource endpoint
     */
    @When("the user sends a DELETE request to {string}")
    @When("sends a DELETE request to {string}")
    public void sendsDELETERequest(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.delete(endpointMapped);
    }

    /**
     * Verifies status code.
     * @param expectedStatusCode
     */
    @Then("verifies response should have the {int} status code")
    public void verifiesStatusCode(final int expectedStatusCode) {
        Assert.assertEquals(response.statusCode(), expectedStatusCode);
    }

    /**
     * Verifies response body with json schema.
     *
     * @param schemaPath schema path
     */
    @And("verifies response body should match with {string} JSON schema")
    public void verifiesResponseBodyJSONSchema(final String schemaPath) {
        JsonSchemaValidator.validate(response, PivotalEnvironment.getInstance().getSchemasPath() + schemaPath);
    }

    /**
     * Stores a value in project id.
     *
     * @param type String
     * @throws IOException
     */
    @When("the user stores an invalid value as {string} in workspace")
    public void storesInvalidIdInWorkspace(final String type) throws IOException {
        if ("label id".equals(type)) {
            context.getData().replace("id", "9999999999999");
        } else if (("project id".equals(type)) && (context.getData().size() != 0)) {
            context.getData().replace("project_id", "9999999999999");
        } else {
            context.saveData("{\"id\":\"999999999999\"}");
        }
    }

    /**
     * Stores the project id of response.
     */
    @And("stores the project id to compare it with returned in body response")
    public void storesProjectId() {
        projectId = context.getValueData("id");
    }

    /**
     * Creates the table.
     *
     * @param valuesToMatch Map of values
     */
    @And("creates the table for next step")
    public void createsTable(final Map<String, String> valuesToMatch) {
        valuesMapped = Mapper.mapValue(projectId, valuesToMatch);
    }

    /**
     * Maps the variable for scenario outline.
     *
     * @param docString String of table
     */
    @Given ("the user sets the following json body")
    public void variableWithoutTable(final String docString) {
        valuesMapped = docString;
    }

    /**
     * Verifies response values.
     *
     * @param expectedValues expected response values
     */
    @And("verifies response should contain the following values")
    public void verifiesResponseValues(final Map<String, String> expectedValues) {
        ResponseBodyValidator.validate(response, expectedValues);
    }

    /**
     * Verifies response body values.
     *
     * @param expectedValues expected response values
     */
    @And("verifies response contain the following values")
    public void verifiesResponseBody(final Map<String, String> expectedValues) throws IOException {
        ResponseBodyValidator.validateBody(response, context.getData(), expectedValues);
    }

    /**
     * Verifies response body values.
     *
     * @param expectedValues expected response values
     */
    @And("verifies the response contain the following values")
    public void verifiesResponseBodyValues(final Map<String, String> expectedValues) throws IOException {
        context.saveData(response.asString());
        ResponseBodyValidator.validateBody(response, context.getData(), expectedValues);
    }

    /**
     * Stores workspace id to clean workspace.
     */
    @And("stores workspace id to clean workspace")
    public void storeTheIdWorkspace() throws IOException {
        context.saveData(response.asString());
    }
}
