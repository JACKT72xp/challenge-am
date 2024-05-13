# Setup Guide for MicroK8s, Temporal.io, and Neo4j Deployment

## Part 1: Virtual Machines Setup and MicroK8s Installation

### Objective:
Create two Linux-based virtual machines and install MicroK8s on both.

1. Use a preferred virtualization tool (e.g., VirtualBox, VMware, Multipass) to create two Linux VMs.
2. Install MicroK8s on each VM following the official documentation.
3. Validate the MicroK8s installation by deploying a test application.

## Part 2: Deploying Temporal.io and Neo4j

### Objective:
Deploy Temporal.io on the MicroK8s clusters and install Neo4j databases on each machine.

1. Deploy Temporal.io on both MicroK8s clusters.
2. Install Neo4j on each VM and ensure each instance is accessible from the local network.
3. Configure Temporal.io to communicate with the local Neo4j instances or VMs.

## Part 3: Connecting Clusters and Deploying a Distributed Workflow

### Objective:
Connect the two MicroK8s clusters and deploy a simple distributed workflow using Temporal.io workers involving both Neo4j instances.

1. Choose a method to connect the two clusters (service mesh, SSH, API servers, federation) and implement it.
2. Create a simple Temporal.io workflow demonstrating distributed execution capability by utilizing workers from both clusters.
3. Validate the workflow execution and ensure data manipulation across both Neo4j databases.

## Documentation and Explanation

### Connectivity Method:

We opted for using a combination of SSH for initial setup and Ansible for automated deployment. Ansible allows for streamlined configuration management, while SSH enables secure remote access to the VMs.

### Workflow Logic:

The workflow involves simple tasks that interact with Neo4j databases deployed on each cluster. These tasks showcase the distributed execution capability of Temporal.io by leveraging workers from both clusters.

### Challenges Faced and Solutions Implemented:

1. **Network Configuration**: Ensuring proper network connectivity between clusters.
   - **Solution**: Configuring network settings and firewall rules to allow communication between clusters.

2. **Automated Deployment**: Ensuring smooth deployment of Temporal.io and Neo4j across clusters.
   - **Solution**: Utilizing Ansible playbooks for automated provisioning and configuration management.

3. **Data Consistency**: Ensuring data consistency and synchronization between Neo4j instances.
   - **Solution**: Implementing synchronization mechanisms or utilizing Temporal.io's built-in data handling features.

### Technology Choices:

1. **MicroK8s**: Chosen for its lightweight Kubernetes distribution, ideal for setting up clusters on VMs.
2. **Temporal.io**: Selected for its workflow orchestration capabilities and distributed execution support.
3. **Neo4j**: Chosen as the database solution for its graph data model, suitable for complex relationships.

## Submission Requirements

1. Detailed setup guide documented in this README.md file.
2. Configuration files, scripts, and code for the deployed Temporal.io workflow uploaded to a private Git repository.
3. README file in the repository explaining connectivity method, workflow logic, challenges faced, solutions implemented, and technology choices rationale.

## GitHub Actions and Ansible Integration

GitHub Actions can be integrated into the workflow to automate deployment pipelines. Ansible playbooks can be used within these actions to provision and configure the VMs and Kubernetes clusters. Continuous integration and deployment (CI/CD) pipelines can ensure smooth and consistent deployment processes.

For Ansible integration, refer to the `ssh/playbook.yml` file in the infrastructure directory for an example playbook. This playbook can be expanded to include additional tasks for setting up MicroK8s, deploying Temporal.io, and configuring Neo4j.

## Directory Structure
´´´
├── README.md
├── code
│ ├── go.mod
│ ├── go.sum
│ ├── main.go
│ ├── myTemporalApp
│ └── myTemporalWorker
└── infrastructure
├── configuration
│ ├── hosts.ini
│ └── setup.yml
├── node1_kubeconfig
├── node2_kubeconfig
├── provider
│ ├── backend.tf
│ ├── namespace.tf
│ ├── neo4j.tf
│ ├── terraform.tfstate
│ └── terraform.tfstate.backup
├── ssh
│ ├── hosts.ini
│ └── playbook.yml
└── temporal.io
└── init_namespaces.sh
´´´


This structure organizes the project into code, infrastructure, and documentation sections for clarity and ease of management.

## Conclusion

This README provides a comprehensive guide for setting up MicroK8s, deploying Temporal.io, and Neo4j databases across clusters, along with explanations of connectivity methods, workflow logic, challenges, and technology choices. Integration with GitHub Actions and Ansible streamlines deployment processes, ensuring efficiency and consistency.
