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

import java.util.Map;

public class RequestStepDefs {
    private Response response;
    private Context context;

    public RequestStepDefs(Context context){
        this.context = context;
    }

    @Given("the user sets valid authentication to request")
    public void theUserSetsValidAuthenticationToRequest() {
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
    }

    @When("the user sends a POST request to {string} with the following Json data")
    public void theUserSendsAPOSTRequestToWithTheFollowingJsonData(final String endpoint, final String body) {
        response = RequestManager.post(endpoint, body);
    }
    @And("store the id_workspace")
    public void storeTheIdWorkspace() {
        context.saveData("id",response.getBody().jsonPath().getString("id"));
    }

    @Then("verifies response should have the {int} status code")
    public void verifiesResponseShouldHaveTheStatusCode(int expectedStatusCode) {
        Assert.assertEquals(response.statusCode(), expectedStatusCode);
    }

    @And("verifies response body should match with {string} JSON schema")
    public void verifiesResponseBodyShouldMatchWithJSONSchema(final String schemaPath) {
        JsonSchemaValidator.validate(response, PivotalEnvironment.getInstance().getSchemasPath() + schemaPath);
    }

    @And("verifies response contain the following values")
    public void verifiesResponseContainTheFollowingValues(final Map<String, String> expectedValues) {
        ResponseBodyValidator.validate(response, expectedValues);
    }

    /**
     * delete workspace
     * @param endpoint
     */
    @When("the user sends a DELETE request to {string}")
    public void theUserSendsADELETERequestTo(final String endpoint, int id_workspace) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.delete(endpointMapped);
    }

    /**
     * Sends a GET request.
     * @param endpoint resource endpoint
     */
    @When("the user sends a GET request to {string}")
    public void sendsGETRequest(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.get(endpointMapped);
    }

    @When("the user sends a PUT request to {string} with the following Json data")
    public void sendsAPUTRequestToWithTheFollowingJsonData(final String endpoint,final  String id_workspace) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getData());
        response = RequestManager.put(endpointMapped, id_workspace);
    }
}
