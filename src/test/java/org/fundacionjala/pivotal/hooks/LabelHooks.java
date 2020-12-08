package org.fundacionjala.pivotal.hooks;

import io.cucumber.java.Before;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.config.PivotalEnvironment;
import org.fundacionjala.pivotal.context.Context;

import java.io.IOException;
import java.util.Date;

public class LabelHooks {

    private Context context;
    private String projectId;

    /**
     * Constructor for the LabelHooks.
     *
     * @param contextToSet Context to Set
     */
    public LabelHooks(final Context contextToSet) {
        this.context = contextToSet;
        this.projectId = context.getValueData("id");
    }

    /**
     * Creates label in the project.
     */
    @Before(value = "@createLabel")
    public void createLabel() throws IOException {
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl()
                        + "/projects/" + projectId + "/labels/";
        String name = "label".concat(Long.toString(new Date().getTime()));
        String body = "{\"name\":\"" + name + "\"}";
        Response response = RequestManager.post(endpoint, body);
        context.saveData(response.asString());
    }

    /**
     * Creates labels in the project.
     */
    @Before(value = "@createLabels")
    public void createLabels() throws IOException {
        createLabel();
        createLabel();
    }

    /**
     * Creates label in the story of project.
     */
    @Before(value = "@createStoryLabel")
    public void createStoryLabel() throws IOException {
        String storyId = context.getValueData("id");
        String endpoint = PivotalEnvironment.getInstance().getBaseUrl()
                        + "/projects/" + context.getValueData("project_id") + "/stories/" + storyId + "/labels/";
        String body = "{\"name\":\"my new label\"}";
        Response response = RequestManager.post(endpoint, body);
        String responseToSave = response.asString().split("}")[0] + ",\"story_id\":\"" + storyId + "\"}";
        context.saveData(responseToSave);
    }
}
