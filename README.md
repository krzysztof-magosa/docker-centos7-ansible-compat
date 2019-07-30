# CentOS 7 - Ansible Compatible

Prototyping and testing of Ansible code can usually be performed inside container
even if it is later used on virtual machine or bare metal. Most of time you simply do not need
low-level functionalities available only on standalone system. However typical Docker image
lacks few standard components and/or ability to run multiple services at once using standard
service manager. This Docker image simply covers that on top of official image.

These lacks could be also covered within your Packer/Molecule configuration (which is quite typical)
but that means you waste resources of your CI/CD (and yours on waiting) just to repeat the same thing
multiple times per day while it can be done once during image build. Docker cache could alleviate
this issue but most of time tests are run within isolated environment on CI/CD platform without access to it
or cache is cleared very often to avoid filling disks.

Yes, it's just about saving 30-60 seconds during each run of tests.  
No rocket science included, just a bit of impatience, sorry :)

## Usage
Molecule:
```
[...]
platforms:
  - name: ${TOX_ENVNAME}-centos7
    image: krzysztofmagosa/centos7-ansible-compat
    pre_build_image: true
    command: /sbin/init
    tmpfs:
      - /run
      - /tmp
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
[...]
```
