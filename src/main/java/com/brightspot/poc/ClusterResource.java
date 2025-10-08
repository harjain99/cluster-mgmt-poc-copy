package com.brightspot.poc;

import java.util.List;

import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Path("/clusters")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ClusterResource {

    @Inject
    ClusterSyncService service;

    @GET
    public List<Cluster> getAll() {
        return service.findAll();
    }

    @GET
    @Path("{name}")
    public Cluster getSingle(@PathParam("name") String name) {
        log.info("Getting cluster with name {}", name);
        return service.get(name);
    }

    @POST
    public List<Cluster> add(Cluster cluster) {
        service.add(cluster);
        return getAll();
    }

    //    @GET
    //    @Produces(MediaType.APPLICATION_JSON)
    //    public Cluster hello() {
    //        return Cluster.builder()
    //            .id(UUID.randomUUID())
    //            .name("Matt")
    //            .arn("arnid1")
    //            .description("new cluster")
    //            .build();
    //    }
}
