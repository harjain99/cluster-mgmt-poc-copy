package com.brightspot.poc;

import java.util.Map;
import java.util.UUID;

import lombok.Builder;
import lombok.Data;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

@Data
@Builder
public class Cluster {

    UUID id;
    String name;
    String arn;
    String description;

    public void save() {
        var dynamoDbClient = createDynamoDbClient();
        var enhancedClient = software.amazon.awssdk.enhanced.dynamodb.DynamoDbEnhancedClient.builder()
            .dynamoDbClient(dynamoDbClient)
            .build();
        var table = enhancedClient.table("Cluster",
            software.amazon.awssdk.enhanced.dynamodb.TableSchema.fromBean(Cluster.class));
        table.putItem(this);
    }

    // Create DynamoDbClient (configure as needed for your environment)
    private software.amazon.awssdk.services.dynamodb.DynamoDbClient createDynamoDbClient() {
        return software.amazon.awssdk.services.dynamodb.DynamoDbClient.builder().build();
    }

    public static Cluster from(Map<String, AttributeValue> item) {
        ClusterBuilder clusterBuilder = Cluster.builder();

        if (item != null && !item.isEmpty()) {
            clusterBuilder.id(UUID.fromString(item.get(AbstractService.CLUSTER_ID).s()));
            clusterBuilder.name(item.get(AbstractService.CLUSTER_NAME).s());
            clusterBuilder.arn(item.get(AbstractService.CLUSTER_ARN).s());
            clusterBuilder.description(item.get(AbstractService.CLUSTER_DESCRIPTION).s());
        }

        return clusterBuilder.build();
    }
}
