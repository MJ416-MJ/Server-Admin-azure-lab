Project: Virtual Cloud Server with Git Integration

This project demonstrates the installation and use of Git on a Linux virtual machine hosted in Microsoft Azure. It also demonstrates secure SSH authentication, collaborative GitHub workflows, repository deployment, and automation using GitHub Actions.

Team Members and Contributions



Malcolm

Malcolm was responsible for the GitHub repository and deployment automation. His contributions included:

* Creating the `Server-Admin-azure-lab` GitHub repository.
* Inviting the other group members as repository collaborators.
* Generating and configuring the required SSH keys.
* Adding the relevant public key to GitHub.
* Cloning and working with the GitHub repository.
* Creating `.github/workflows/deploy.yaml`.
* Configuring the GitHub Actions secrets `VM\\\_SSH\\\_KEY`, `VM\\\_HOST`, and `VM\\\_USER`.
* Configuring the workflow to run automatically when changes are pushed to the `main` branch.
* Configuring the workflow to connect to the Azure VM and execute the deployment script.
* Creating branches and pull requests and merging approved changes into `main`.
* Testing and troubleshooting the GitHub Actions workflow.
* Documenting the GitHub, SSH-key, and automation procedures in `docs/malcolm-notes.md`.



Pritpal

Pritpal was responsible for the Azure Linux virtual machine and server-side deployment. Her contributions included:

* Provisioning and administering the Azure Linux virtual machine.
* Creating Linux user accounts for the group members.
* Adding the group members' public SSH keys to the appropriate user accounts.
* Installing or verifying Git on the Linux server.
* Configuring the Azure VM to authenticate with GitHub.
* Cloning the repository to `/home/pritpal/Server-Admin-azure-lab`.
* Creating the `scripts/deploy.sh` deployment script.
* Configuring the deployment script to retrieve updates from the repository's `main` branch.
* Adding deployment logging through `deploy.log`.
* Testing the deployment script on the Azure VM.
* Confirming that the script detected and deployed new commits.
* Starting and stopping the Azure VM when required for testing.



Success

Success was responsible for the group contribution documentation and participated in the secure-access and GitHub collaboration process. The contributions included:

* Generating an Ed25519 SSH key pair for secure access to the Azure VM.
* Supplying the public key to the Azure VM administrator.
* Keeping the corresponding private key secure on the local computer.
* Troubleshooting SSH connectivity to the assigned Linux account.
* Reviewing the group members' technical work and supporting evidence.
* Preparing `docs/CONTRIBUTIONS.md`.
* Documenting the responsibilities completed by each group member.
* Working on a separate Git branch.
* Committing and pushing the contribution documentation to GitHub.
* Creating a pull request so the documentation could be reviewed before being merged into `main`.



GitHub Collaboration Workflow

The group used the following collaborative workflow:

1. Malcolm created the GitHub repository and invited the other group members as collaborators.
2. SSH keys were generated and configured for secure authentication.
3. The repository was cloned to the Azure Linux VM.
4. Group members completed their assigned tasks on separate Git branches.
5. Changes were committed and pushed to GitHub.
6. Pull requests were used to review changes before merging them into `main`.
7. A push to `main` triggered the GitHub Actions workflow.
8. GitHub Actions connected to the Azure VM through SSH.
9. The workflow executed `/home/pritpal/Server-Admin-azure-lab/scripts/deploy.sh`.
10. The deployment script pulled the latest changes from `main` and recorded the deployment result in `deploy.log`.



SSH-Key Roles

Separate SSH keys were used for different purposes.

Team Member to Azure VM

Each team member generated an SSH key pair. The public key was provided to the VM administrator and added to the appropriate Linux account's `authorized\\\_keys` file. The private key remained securely stored on the team member's computer.

Azure VM to GitHub

A server-side SSH key allowed the Azure VM to authenticate with GitHub and pull changes from the repository.

GitHub Actions to Azure VM

A separate deployment key allowed GitHub Actions to authenticate with the Azure VM. Its private key was stored securely in the `VM\\\_SSH\\\_KEY` GitHub Actions secret, while its public key was added to the appropriate account on the VM.

Keeping these keys separate ensured that each key had one defined purpose and could be replaced without affecting the other connections.



GitHub Actions Configuration

The workflow is stored at `.github/workflows/deploy.yaml`. It performs the following tasks:

1. Runs when a change is pushed to `main` or when manually started using `workflow\\\_dispatch`.
2. Checks out the repository.
3. Confirms that `README.md` exists.
4. Reads the VM connection information from GitHub Actions secrets.
5. Creates an SSH configuration for the workflow runner.
6. Connects to the Azure VM through SSH.
7. Runs the deployment script on the VM.

The configured secrets are:

* `VM\\\_SSH\\\_KEY` — the private deployment key used by GitHub Actions.
* `VM\\\_HOST` — the public IP address or hostname of the Azure VM.
* `VM\\\_USER` — the Linux account used by the automated workflow.

Secret values and private keys were not committed to the repository.

Deployment Script

The deployment script is stored at `scripts/deploy.sh`. On the Azure VM, its complete path is:

/home/pritpal/Server-Admin-azure-lab/scripts/deploy.sh



The script retrieves the latest version of the repository and records deployment activity in `deploy.log`. Testing confirmed that the script could detect an updated commit and complete the deployment process.



Troubleshooting

The group encountered and resolved several issues during the project:

* A YAML workflow file was initially saved by Notepad with an incorrect `.txt` extension and was later saved correctly as a `.yaml` file.
* An SSH permission error occurred when an incorrect Linux username was used.
* The deployment script initially existed on a separate branch and had to be merged into `main`.
* The VM copy of the repository had to pull the updated `main` branch before `scripts/deploy.sh` became available.
* The full deployment-script path had to be added to the GitHub Actions workflow.
* SSH connectivity to an individual user account required additional troubleshooting.



Evidence Collected

The group's supporting evidence includes:

* Git installation and Git version output.
* SSH-key generation and public-key configuration.
* Successful GitHub SSH authentication.
* Creation of the GitHub repository.
* Repository cloning on the Azure VM.
* Git branches, commits, and pull requests.
* GitHub Actions secrets and workflow configuration.
* Successful GitHub Actions execution.
* Successful execution of `scripts/deploy.sh`.
* Deployment-log output showing that new commits were detected.
* Group communication and division of responsibilities.



Security Measures

The group followed these security practices:

* Private SSH keys were not shared between team members.
* Only public SSH keys were sent to the VM administrator.
* Private keys and secret values were not committed to GitHub.
* Sensitive deployment values were stored as GitHub Actions secrets.
* Different SSH keys were used for user access and automated deployment.
* The `.gitignore` file was used to reduce the risk of accidentally committing sensitive or unnecessary files.



