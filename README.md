# Setup Guide for MicroK8s, Temporal.io, and Neo4j Deployment

~~ # 	Part 1: Virtual Machines Setup and MicroK8s Installation~~

## Objective:
Create two Linux-based virtual machines and install MicroK8s on both.

1. **Manual Virtual Machine Creation:**
   - Utilize a preferred virtualization tool such as VMware Fusion or vSphere to manually create two Linux VMs.
   - Ensure each VM is configured with a minimum of 8GB of RAM and 2 CPUs.
   - Install Ubuntu 24.02 (ARM version) on each VM.

2. **Manual MicroK8s Installation:**
   - After VM creation and Ubuntu installation, manually install MicroK8s on each VM.
   - Due to ARM architecture limitations, manual installation is preferred over package installation.
   - Follow the official MicroK8s documentation for manual installation steps tailored to ARM architecture.

3. **Validation of MicroK8s Installation:**
   - Validate the MicroK8s installation by deploying a test application.
   - Confirm that the test application runs smoothly on both VMs and MicroK8s clusters.

## Detailed Steps:

### Manual VM Creation:
1. Open VMware Fusion or vSphere and start the process to create a new virtual machine.
2. Choose Ubuntu 24.02 ARM as the guest operating system.
3. Allocate at least 8GB of RAM and 2 CPUs to each VM during the configuration process.
4. Complete the VM creation wizard and ensure that both VMs are successfully created.

### Ubuntu Installation:
1. Boot each VM and follow the prompts to install Ubuntu 24.02 ARM.
2. Select appropriate options such as language, keyboard layout, and disk partitioning.
3. Complete the installation process and ensure that Ubuntu boots up successfully on both VMs.

### Manual MicroK8s Installation:
1. SSH into each VM or access them via the console.
2. Download the MicroK8s installation script for ARM architecture.
3. Run the installation script with appropriate permissions to install MicroK8s on each VM.
4. Follow any on-screen prompts and post-installation instructions provided by the script.
5. Verify that MicroK8s is installed correctly by checking the version and status.

### Test Application Deployment:
1. Choose a simple test application such as "Hello World" or a sample web server.
2. Create Kubernetes manifests or Helm charts to deploy the test application on both MicroK8s clusters.
3. Apply the manifests or Helm charts to deploy the test application.
4. Access the deployed application to ensure it is running as expected on both clusters.

## Considerations:
- **Hardware Limitations:** Ensure that each VM is allocated sufficient resources (8GB RAM, 2 CPUs) to run MicroK8s smoothly.
- **ARM Architecture:** Due to ARM architecture limitations, manual installation of MicroK8s is preferred over package installation.
- **Directory Structure:** All related files and configurations should be organized within the project directory for easy access and management.


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
```

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
```


This structure organizes the project into code, infrastructure, and documentation sections for clarity and ease of management.

## Conclusion

This README provides a comprehensive guide for setting up MicroK8s, deploying Temporal.io, and Neo4j databases across clusters, along with explanations of connectivity methods, workflow logic, challenges, and technology choices. Integration with GitHub Actions and Ansible streamlines deployment processes, ensuring efficiency and consistency.
