# Malcolm -Guide Section : Github Repo, SSH keys and the Actions Workflow
## 1. Overview
This part of the lab basically covers the Github aspect and the automation that connects to the Azure Server. First, the repositiory i.e Server-Admin-azure-lab is created, a personal SSH key  is used to ensure code is pushed securely from the local machine. I also invited my teammates as collaborators. A GitHub Actions workflow was built to ensure whenever code was pushed to the main branch, a basic check is done and then logs in to the server over SSH to run on the deploy script done by Pritpal. This connects to Pritpal's work on the server and then feeds into the guide and contributions documentation.

## 2 Generating the SSH key
Command 'ssh-keygen -t ed25519 -C "Malcolm-John"' -t stands for key type and -C stands for comment
The passphrase was left empty to allow ease of access for the case of the lab.
## 3 Adding the key to GitHub and testing it
The public key was added to the GitHub account under Settings then SSH keys.
The connection was tested using ssh -T git@github.com and a warning was displayed stating that the authenticity couldnt be established which is normal at first and then after typing yes, it replies with successful.

## 4 Creating the repository
A public repository with a README and a Node .gitignore. The gitignore file is used to ensure files such as secrets are never tracked.

## 5 Cloning and committing
 git clone git@github.com:MJ416-MJ/Server-Admin-azure-lab.git
    git config user.name "Malcolm"
    git config user.email "<malcolm.nezereab@strathmore.edu"
The last two commands configure the user’s name and their git email to basically tell git who to write on each commit made by this user, for logging purposes

## 6 The two key concept
Two separate SSH key pairs are used in the automation, and they work in
opposite directions. The first lets the server talk to GitHub: Pritpal generates it on the VM and adds the public half to her GitHub account, so the server can pull code from the repository as a collaborator.
The second lets GitHub Actions talk to the server: This was generated with 
`ssh-keygen -t ed25519 -f C:\Users\malco\.ssh\deploy_key -C "github-actions" -N ""`, 
which stored the private half in the `VM_SSH_KEY` secret, and sent the public half to
Pritpal to add to `authorized_keys` on the VM. The passphrase is empty because
Actions runs unattended. The key was saved outside the repository so it could not be committed by accident. Keeping the two keys separate means each has a single job and can be replaced without
affecting the other.
## 7 GitHub Secrets
This was Added under Settings> Secrets and Variables> Actions
The three secrets are VM_SSH_KEY which contains the private deploy_key contents
VM_HOST - the public IP of the VM
VM_USER the linux user public key was added to

## 8 The workflow 
This can be found within the .github/workflows/deploy.yaml
It triggers a push to the main plus a manual workflow_dispatch button. this is within the **Triggers** section
It checks out the repo and confirms the existence of the README.md. This is within the **check job** seciton
Once the check passes i.e (needs:check), **deploy job** runs and writess the private key from secrets.VM_SSH_KEY, sets the permissions to 600 i.e only reading and writing is available to owner, adds the VM with ssh-keyscan then attempts to ssh into the VM and runs deploy.sh.
- ${{ secrets.NAME }} reads a secret without necessarily exposing it in code.

- ## 9 Branch, pull request and merge
- A branch was created to avoid a failing run due to the initial absence of the VM_HOST and VM_USER secrets.
- This was done using the following commands
    git checkout -b feature/add-workflow
    git push -u origin feature/add-workflow
- Once secrets and script were set, a pull request was made into main. After review, the merge was initiated and this caused the workflow to be triggered.

  ## 10 Troubleshooting.
  Notepad initally saved the yaml file as a .txt rather than .yaml, so I resaved it correctly.
  A permissions denied error due to keying in the wrong user.
