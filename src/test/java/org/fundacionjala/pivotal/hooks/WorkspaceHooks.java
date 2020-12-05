package org.fundacionjala.pivotal.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;

import java.util.Date;

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

    /**
     * create project.
     */
    @Before(value = "@createProject")
    public void createProject() {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects";
        String body = "{\"name\":\"Executioner\"}";
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
        Response response = RequestManager.post(endpoint, body);
        context.saveData("project_id", response.getBody().jsonPath().getString("id"));
    }

    /**
     * create workspace.
     */
    @Before(value = "@createWorkspace")
    public void createWorkspace() {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/my/workspaces";
        String name = "workspace".concat(Long.toString(new Date().getTime()));
        String body = "{\"name\":\"" + name + "\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData("workspace_id", response.getBody().jsonPath().getString("id"));
    }

    /**
     * delete workspace.
     */
    @After(value = "@deleteWorkspace")
    public void deleteWorkspace() {
        String workspaceId = context.getValueData("workspace_id");
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/my/workspaces/" +  workspaceId;
        RequestManager.delete(endpoint);
    }
}
