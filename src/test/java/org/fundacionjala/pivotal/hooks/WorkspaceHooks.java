package org.fundacionjala.pivotal.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;

public class WorkspaceHooks {
    private Context context;
    private static final String TOKEN_HEADER = "X-TrackerToken";
    private static RequestSpecification requestSpecification;

    /**
     * Constructor for the WorkspaceHooks.
     * @param contextToSet
     */
    public WorkspaceHooks(final Context contextToSet) {
        this.context = contextToSet;
    }


    @Before(value = "@createProject")
    public void createProject() {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects";
        String body = "{\"name\":\"Executioner\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData("project_id", response.getBody().jsonPath().getString("id"));
    }

    @Before(value = "@createWorkspace")
    public void createWorkspace() {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/my/workspace/";
        String body = "{\"name\":\"my workspace\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData("workspace_id", response.getBody().jsonPath().getString("id"));
        AuthenticationUtils.getLoggedReqSpec();
        RequestManager.post(endpoint, body);
    }

    @After
    public void deleteWorkspace() {
        String workspaceId = context.getValueData("id");
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/my/workspace/" +  workspaceId;
        AuthenticationUtils.getLoggedReqSpec();
        RequestManager.delete(endpoint);
    }
}
