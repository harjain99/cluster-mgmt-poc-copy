package com.brightspot.poc;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
class ClusterResourceTest {
    //    @Test
    //    void testHelloEndpoint() {
    //        given()
    //          .when().get("/cluster")
    //          .then()
    //             .statusCode(200)
    //             .body(is("Hello RESTEasy"));
    //    }
}