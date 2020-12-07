package org.fundacionjala.pivotal.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.core.utils.Mapper;
import org.fundacionjala.core.utils.JsonSchemaValidator;
import org.fundacionjala.pivotal.context.Context;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;
import org.fundacionjala.pivotal.utils.ResponseBodyValidator;
import org.testng.Assert;

import java.util.Map;

public class RequestStepDefs {

    private Response response;
    private Context context;

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
    @Given("The user sets valid authentication to request")
    public void setsValidAuthentication() {
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
    }

    /**
     * Sends a GET request.
     *
     * @param endpoint resource endpoint
     */
    @When("the user sends a GET request to {string}")
    public void sendsGETRequest(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.get(endpointMapped);
    }

    /**
     * Verifies response status code.
     *
     * @param expectedStatusCode expected status code
     */
    @Then("verifies response should have the {int} status code")
    public void verifiesStatusCode(final int expectedStatusCode) {
        Assert.assertEquals(response.statusCode(), expectedStatusCode);
    }

    /**
     * Verifies response body json schema.
     *
     * @param schemaPath schema path
     */
    @And("verifies response body should match with {string} JSON schema")
    public void verifiesResponseBodyMatchWithJSONSchema(final String schemaPath) {
        JsonSchemaValidator.validate(response, schemaPath);
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

    @When("the user sends a POST request to {string} with the following Json data")
    public void SendsPOSTRequest(String endpoint, String body) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.post(endpointMapped, body);
    }

    @When("the user sends a GET request to {string} with the following Json data")
    public void theUserSendsAGETRequestToWithTheFollowingJsonData(String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.get(endpointMapped);
    }
}