package org.fundacionjala.pivotal.config;

import junit.framework.TestCase;
import org.testng.Assert;
import org.testng.annotations.Test;

public class PivotalEnvironmentTest extends TestCase {

    /**
     * Test get BaseUrl value from gradle.properties.
     */
    @Test
    public void getBaseUrlTest() {
        PivotalEnvironment piv = PivotalEnvironment.getInstance();
        String actual  = piv.getBaseUrl();
        String expected = "https://www.pivotaltracker.com/services/v5";
        Assert.assertEquals(actual, expected);
    }
}
