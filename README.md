This is a simple project to deploy a Jenkins server on the AWS Cloud in a Declarative way, using Terraform.
This eliminates the burden to set Jenkins Server manually.
The Detailed Video Can be found on <b>AOS Note</b> <a href="https://www.youtube.com/watch?v=9XrYwfIWDL0" target="_blank">YouTube channel</a>

[N.B. You can also install Jenkins on Windows: See instruction the end of this page]


We have split the main terraform file into three files:
  - instance.tf: This file is the Main File that declare the resources, the AMI images, the Availability Zones, the ports mapping, the access method, etc.
  - vars.tf: This file contains the variables. It is not necessary to split it this way, but is very useful when we want to quickly change a variable. Modular development is always a good practice
  - web.sh : This file contains the provisioning commands: the installation command for installing anything we want, once the instances have started. This is where we declare the Jenkins installation packages and its dependencies
  
  
<b> Instructions: </b>

<b>I. From AWS Console</b>

- Login to your AWS Account and create an <b>iam user</b> or used and <b>existing iam user</b>, then download the <b>iam credential</b> to configure your local command line interface to communicate with your AWS account.
- Login to your AWS Account and create a <b>pem</b> Key-Pair. mine is "tchamna_aws.pem", but it is a good practice to give a name that reflect the service you are running. For Example, "jenkins_key.pem"

<b>II. From your Local Computer</b>

- Place the pem key in the root directory of your project
- Open a terminal. I recommend <b> git bash</b> if you are on windows (download and install it)
- Change the directory with a cd command from the terminal and point to the directory of your project
- Run the terraforms commands:
- <b> terraform init</b>: The terraform init command initializes your working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.
- <b>terraform plan </b> (This is optional): The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. 
-  <b>terraform fmt</b> (This is optional, but good practice): To format and present your terraform in a nice and more presentable way
-  <b>terraform validate</b> (This is optional): To check compiling and syntax errors in the .tf files
-  <b>terraform apply</b>: The terraform apply command executes the actions proposed in a Terraform plan.

<b> Bonus: Install Jenkins on Windows </b>


1.Install the right java version (mine is <b>"17.0.4.1" 2022-08-18 LTS</b> at the time I am writting) : https://www.oracle.com/java/technologies/downloads/. Jenkins requires Java 11 or 17 since Jenkins 2.357 and LTS 2.361.1.
2.  Download Jenkins as a war file from here: https://www.jenkins.io/doc/book/installing/war-file/. 
3. Create a Folder and place the war file inside
4. Open a terminal and navigate in that folder
5. Run the following command <b> java -jar jenkins.war --httpPort=8080 </b> Note that you can change the port; it doesnt have to be 8080
6. Open a browser and paste the following url: <b>http://localhost:8080/</b>
7. Jenkins landing page will open and indicate where you can find the initial pasword. You can also find it in your terminal. Just scroll up
8. Copy the initial password and paste it in Jenkins, then click <b> Continue</b> and there you go!


