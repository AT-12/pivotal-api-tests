package org.fundacionjala.pivotal.config;

import junit.framework.TestCase;
import org.testng.Assert;
import org.testng.annotations.Test;

public class PivotalEnvironmentTest extends TestCase {

    /**
     * Test get Token value from gradle.properties.
     */
    @Test
    public void endPointWithOneParamTest() {
        PivotalEnvironment piv = PivotalEnvironment.getInstance();
        String actual  = piv.getBaseUrl();
        Assert.assertEquals(actual, "");
    }
}
