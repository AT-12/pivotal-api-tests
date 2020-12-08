package org.fundacionjala.pivotal.hooks;

import io.cucumber.java.Before;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;

import java.io.IOException;
import java.util.Date;

public class StoryHooks {

    private Context context;

    /**
     * Constructor for the ProjectHooks.
     * @param contextToSet Context to Set
     */
    public StoryHooks(final Context contextToSet) {
        this.context = contextToSet;
    }

    /**
     * Creates project.
     */
    @Before(value = "@createStory", order = 1)
    public void createStory() throws IOException {
        String projectId = context.getValueData("id");
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl() + "/projects/" + projectId + "/stories";
        String name = "story".concat(Long.toString(new Date().getTime()));
        String body = "{\"name\":\"" + name + "\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData(response.asString());
    }
}
