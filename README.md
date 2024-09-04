# deploying k8's on aws
the cost of using a managed kubernetes cluster is high , so that we aim to create a customized kubernetes cluster using an open source tool like kubespray , with terraform for the cloud infrastructure provisioning.
<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://plugins.jetbrains.com/files/7808/595185/icon/pluginIcon.png">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Terraform HCL</h3>

  <p align="center">
    Provisioning of a kubespray kubernetes cluster on aws with terraform !
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template">View Demo</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#infra_prov">Infrastructure provisioning</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

There are many great README templates available on GitHub; however, I didn't find one that really suited my needs so I created this enhanced one. I want to create a README template so amazing that it'll be the last one you ever need -- I think this is it.

Here's why:
* Your time should be focused on creating something amazing. A project that solves a problem and helps others
* You shouldn't be doing the same tasks over and over like creating a README from scratch
* You should implement DRY principles to the rest of your life :smile:

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue. Thanks to all the people have contributed to expanding this template!

Use the `BLANK_README.md` to get started.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

* [![Next][Next.js]][Next-url]
* [![React][React.js]][React-url]
* [![Vue][Vue.js]][Vue-url]
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This project will give an insight about provisioning  building a kubernetes cluster  production-ready
on aws using terraform for infra provisiong and an open source  kubespray for cluster provisioning.   

### Prerequisites

first you need to install terraform-cli and aws-cli
* terraform
```sh
curl -LO "https://releases.hashicorp.com/terraform/$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)/terraform_$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)_linux_amd64.zip"
  ```
```sh
  unzip terraform_*.zip
  sudo mv terraform /usr/local/bin/
  ```
* aws-cli
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### setting up the environment

the follow section is about how to set your environment and configure aws account with terraform and provision your aws infra.

1. check if terraform aws are correctly  installed
```sh
terraform --version
aws --version
```
2. Clone the project 
```sh
git clone https://github.com/Enstientt/deploying-k8-s-on-aws.git
cd deploying-k8-s-on-aws
   ```
3. configure aws with your aws account (if you don't already done it)
```sh
aws configure
```
enter the required information:
   - AWS Access Key ID [None]:
   - AWS Secret Access Key [None]
   - Default region name [None]:
   - Default output format [None]: (if empty is json by default)
4. check if aws configured
```sh
aws configure list
```
5. Create the infrastructure (VMs) on aws:
- initial terraform to create aws provider and all the necessary files:
```sh
terrafrom init
```
- plan the provisioning :
```sh
terraform plan
 ```
- create the ressources :
```sh
terraform apply
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Setting up the vms for cluster provisioning
We'll set only one machine and is the same for the 2 others ones.
1. ssh into the machine
First you should get the id_rsa + the public ip address and ssh into your machine.
```sh
ssh -i id_rsa ubuntu@54.19.19.19
```
2. set a password to ubuntu user
```sh
sudo passwd ubuntu
```
3. add the authentication by password
```sh
sudo vim /etc/ssh/sshd_config
```
addthe line
```bash
PasswordAuthentication yes
ChallengeResponseAuthentication yes
```
```sh
sudo systemctl restart ssh
```
4. generate an ssh key
```sh
ssh-keygen -t rsa
```
5. set the hostname for the machine to the convinion name
``` sh
sudo vim /etc/hostname #set to name of the machine master as ex
sudo vim /etc/hosts #assigne the localhost to that name dns resolution
```
6. inssure the acess to other machines without the need of the password (this part is only for the master machine)
```sh
ssh-copy-id master
ssh-copy-id worker01
ssh-copy-id worker02
```
## Cluster provisioning

In this part we'll use kubespray tool for cluster provisiong.
NB: in this section we assume that you re connected by ssh to the master machine
1. clone the kubespray repo
```sh
git clone https://github.com/kubernetes-sigs/kubespray.git
```
2. Ansible installation
This part is already mention in kubespray docummentaion you can follow this link for to get this step done
Link: [https://github.com/kubernetes-sigs/kubespray/blob/master/docs/ansible/ansible.md#installing-ansible](Ansible installation guide)

3. Deploy the k8s cluster
```sh
# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

# Clean up old Kubernetes cluster with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example cleaning up SSL keys in /etc/,
# uninstalling old packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
# And be mind it will remove the current kubernetes cluster (if it's running)!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root reset.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```
After that your cluster is up you can set up a config file to easely interact with cluster
```sh
mkdir ~/.kube
sudo cat /etc/kubernetes/admin.conf > ~/.kube/config
```
You can now run:
```sh
kubectl get pods -n kube-system
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [ ] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
    - [ ] Chinese
    - [ ] Spanish

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

