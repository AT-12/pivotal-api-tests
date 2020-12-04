package org.fundacionjala.pivotal.utils;

import io.restassured.response.Response;
import org.testng.Assert;

import java.util.Map;

/**
 * Defines utility methods for response body validation.
 */
public final class ResponseBodyValidator {

    /**
     * Private constructor for {@link ResponseBodyValidator} utility class.
     */
    private ResponseBodyValidator() {

    }

    /**
     * Validates response body values.
     *
     * @param response       response
     * @param expectedValues expected values
     */
    public static void validate(final Response response, final Map<String, String> expectedValues) {
        for (Map.Entry<String, String> entry : expectedValues.entrySet()) {
            String actualValue = response.jsonPath().getString(entry.getKey());
            String expectedValue = entry.getValue();
            Assert.assertEquals(actualValue, expectedValue);
        }
    }
}
