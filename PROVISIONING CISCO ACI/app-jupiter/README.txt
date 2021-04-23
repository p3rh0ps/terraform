Command to launch to provision a specific application in Cisco ACI Sandbox with Terraform

By using a specific csv file (comma separated) hosting all Jupiter satellites information

-> This application will be named JupiterApp

-> This application will host after 

	terraform init
	terraform plan -out planJupiterApp
	terraform apply "planJupiterApp"

And ouput will be given at the end to the run to verify each passed variables !

To be able to troubleshoot TF, you must use and set the environment variable TF_LOG to any
values or accurately with TRACE, DEBUG, INFO, WARN or ERROR

Certificate are not sync in the Git Repo through .gitignore exception.

Please reinstall your own user certifcate.

To be able to used a Signed Authentication, please use the following procedure:

https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs

If .gitignore do not ignore keys and certs use the following procedure to recover:

git rm -r --cached .
git add .
git commit -m "fixed untracked files"
