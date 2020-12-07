package org.fundacionjala.pivotal.hooks;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ProjectHooks {

    private Context context;

    /**
     * Constructor for the LabelHooks.
     * @param contextToSet Context to Set
     */
    public ProjectHooks(final Context contextToSet) {
        this.context = contextToSet;
    }

    /**
     * Creates project.
     */
    @Before(value = "@createProject", order = 0)
    public void createProject() throws IOException {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects";
        String name = "at-12";
        String body = "{\"name\":\" " + name + "\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData(response.asString().replace("id", "project_id"));
    }

    /**
     * Creates an invalid id.
     */
    @Before(value = "@setInvalidProject", order = 0)
    public void setInvalidProject() {
        Map<String, String> map = new HashMap<String, String>();
        map.put("project_id", "2478593");
        context.setData(map);
    }

    /**
     * Deletes project.
     */
    @After(value = "@deleteProject")
    public void deleteProject() {
        String projectId = context.getValueData("project_id");
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects/" + projectId;
        AuthenticationUtils.getLoggedReqSpec();
        RequestManager.delete(endpoint);
    }
}
