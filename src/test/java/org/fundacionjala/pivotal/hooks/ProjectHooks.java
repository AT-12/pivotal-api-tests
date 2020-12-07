package org.fundacionjala.pivotal.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;

import java.io.IOException;
import java.util.Date;

public class ProjectHooks {

    private Context context;

    /**
     * Constructor for the ProjectHooks.
     * @param contextToSet Context to Set
     */
    public ProjectHooks(final Context contextToSet) {
        this.context = contextToSet;
    }

    /**
     * Creates project.
     */
    @Before(value = "@createProject")
    public void createProject() throws IOException {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects";
        String name = "project".concat(Long.toString(new Date().getTime()));
        String body = "{\"name\":\"" + name + "\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData(response.asString());
    }

    /**
     * Deletes project.
     */
    @After(value = "@deleteProject")
    public void deleteProject() {
        String projectId = context.getValueData("id");
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects/" + projectId;
        AuthenticationUtils.getLoggedReqSpec();
        RequestManager.delete(endpoint);
    }
}
