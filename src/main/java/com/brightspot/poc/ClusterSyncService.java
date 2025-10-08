package com.brightspot.poc;

import java.util.List;
import java.util.stream.Collectors;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;

@ApplicationScoped
public class ClusterSyncService extends AbstractService {

    @Inject
    DynamoDbClient dynamoDB;

    public List<Cluster> findAll() {
        return dynamoDB.scanPaginator(scanRequest()).items().stream()
            .map(Cluster::from)
            .collect(Collectors.toList());
    }

    public void add(Cluster cluster) {
        dynamoDB.putItem(putRequest(cluster));
    }

    public Cluster get(String name) {
        return Cluster.from(dynamoDB.getItem(getRequest(name)).item());
    }
}
