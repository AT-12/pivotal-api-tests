package org.fundacionjala.pivotal.config;

import junit.framework.TestCase;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.HashMap;
import java.util.Map;

public class PivotalEnvironmentTest extends TestCase {

    /**
     * Test get Token value from gradle.properties.
     */
    @Test
    public void endPointWithOneParamTest() {
        PivotalEnvironment piv = new PivotalEnvironment("gradle.properties");
        String actual  = piv.getBaseUrl();
        Assert.assertEquals(actual,"");
    }
}