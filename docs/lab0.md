# Lab0 - Setup ACM Environment

## Description : 

## Steps



1. Build local workstation image or pull from Quay.io
```bash
## with Red Hat VPN
cd tw-tam-demolab
docker build -t demolab-workstation:latest .
## OR
podman pull quay.io/rhn_support_jaliang/demolab-workstation
```


2. Access local workstation image
```bash
docker run -it --rm --name demolab demolab-workstation:latest bash
cd tw-tam-demolab-main
```

3. Replace  your OpenShift access info in var file
```bash
vi ansible-playbook/vars
```

4. Start lab 0
```bash
ansible-playbook --extra-vars "@vars" lab0_acm_deploy.yml
```