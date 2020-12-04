package org.fundacionjala.pivotal.hooks;

import io.cucumber.java.Before;

public class ProjectHooks {

    @Before(value = "@createProject")
    public void createProject(){
        // request para crear project y extraer el ID
        //String value= id;
        //String key = project_id;
        //context.put(project_id, id);

    }
}
