package com.brightspot.poc;

import java.util.HashMap;
import java.util.Map;

import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.PutItemRequest;
import software.amazon.awssdk.services.dynamodb.model.ScanRequest;

public abstract class AbstractService {

    public static final String CLUSTER_ID = "id";
    public static final String CLUSTER_NAME = "name";
    public static final String CLUSTER_ARN = "arn";
    public static final String CLUSTER_DESCRIPTION = "description";
    public static final String CLUSTER_TABLE_NAME = "Clusters";

    protected ScanRequest scanRequest() {
        return ScanRequest.builder().tableName(CLUSTER_TABLE_NAME)
            .attributesToGet(CLUSTER_ID, CLUSTER_NAME, CLUSTER_ARN, CLUSTER_DESCRIPTION).build();
    }

    protected PutItemRequest putRequest(Cluster cluster) {
        Map<String, AttributeValue> item = new HashMap<>();
        item.put(CLUSTER_ID, AttributeValue.builder().s(cluster.getId().toString()).build());
        item.put(CLUSTER_NAME, AttributeValue.builder().s(cluster.getName()).build());
        item.put(CLUSTER_ARN, AttributeValue.builder().s(cluster.getArn()).build());
        item.put(CLUSTER_DESCRIPTION, AttributeValue.builder().s(cluster.getDescription()).build());

        return PutItemRequest.builder()
            .tableName(CLUSTER_TABLE_NAME)
            .item(item)
            .build();
    }

    protected GetItemRequest getRequest(String name) {
        Map<String, AttributeValue> key = new HashMap<>();
        key.put(CLUSTER_NAME, AttributeValue.builder().s(name).build());

        return GetItemRequest.builder()
            .tableName(CLUSTER_TABLE_NAME)
            .key(key)
            .attributesToGet(CLUSTER_ID, CLUSTER_NAME, CLUSTER_ARN, CLUSTER_DESCRIPTION)
            .build();
    }
}
