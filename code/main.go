package main

import (
    "context"
    "log"
    "time"

    "go.temporal.io/sdk/client"
    "go.temporal.io/sdk/worker"
    "go.temporal.io/sdk/workflow"
    "github.com/neo4j/neo4j-go-driver/v4/neo4j"
)

type Neo4jConfig struct {
    URI      string
    Username string
    Password string
}

// Define the workflow
func SampleWorkflow(ctx workflow.Context, neo4jConfigs []Neo4jConfig) error {
    ao := workflow.ActivityOptions{
        StartToCloseTimeout: 10 * time.Minute,
    }
    ctx = workflow.WithActivityOptions(ctx, ao)

    // Execute the activity for each Neo4j instance
    for _, config := range neo4jConfigs {
        if err := workflow.ExecuteActivity(ctx, Neo4jActivity, config).Get(ctx, nil); err != nil {
            return err
        }
    }
    return nil
}

// Define the activity
func Neo4jActivity(ctx context.Context, config Neo4jConfig) error {
    log.Println("Connecting to Neo4j at", config.URI)
    driver, err := neo4j.NewDriver(config.URI, neo4j.BasicAuth(config.Username, config.Password, ""))
    if err != nil {
        log.Printf("Failed to create driver for Neo4j: %s", err)
        return err
    }
    defer driver.Close()

    session := driver.NewSession(neo4j.SessionConfig{AccessMode: neo4j.AccessModeWrite})
    defer session.Close()
    _, err = session.WriteTransaction(func(tx neo4j.Transaction) (interface{}, error) {
        return tx.Run("CREATE (n:Sample {name: 'SampleNode'}) RETURN n.name", nil)
    })

    if err != nil {
        log.Printf("Failed to execute transaction: %s", err)
    }
    return err
}

func startWorkerAndWorkflow(clusterAddress string, taskQueue string, neo4jConfigs []Neo4jConfig) {
    // Create a Temporal client for the given cluster
    c, err := client.NewClient(client.Options{
        HostPort: clusterAddress,
    })
    if err != nil {
        log.Fatalf("Failed to create client for cluster %s: %v", clusterAddress, err)
    }
    defer c.Close()

    // Create and start a worker
    w := worker.New(c, taskQueue, worker.Options{})
    w.RegisterWorkflow(SampleWorkflow)
    w.RegisterActivity(Neo4jActivity)
    go func() {
        if err := w.Run(worker.InterruptCh()); err != nil {
            log.Fatalf("Error running worker for %s: %v", clusterAddress, err)
        }
    }()

    // Start a workflow
    options := client.StartWorkflowOptions{
        ID:        "multiNeo4jWorkflow_" + clusterAddress,
        TaskQueue: taskQueue,
    }
    _, err = c.ExecuteWorkflow(context.Background(), options, SampleWorkflow, neo4jConfigs)
    if err != nil {
        log.Printf("Failed to start workflow on %s: %v", clusterAddress, err)
    }
}

func main() {
    neo4jConfigs := []Neo4jConfig{
        {URI: "neo4j://192.168.36.102:7687", Username: "neo4j", Password: "yvvy0QvixUrqOm"},
        {URI: "neo4j://192.168.36.103:7687", Username: "neo4j", Password: "FxrI56WMPPYHjt"},
    }
    temporalClusters := []string{"192.168.36.102:7233", "192.168.36.103:7233"}

    for _, cluster := range temporalClusters {
        go startWorkerAndWorkflow(cluster, "multi-neo4j-task-queue", neo4jConfigs)
    }

    // Keep the main thread running indefinitely
    select {}
}
