# VLab App Installation Guide for Linux

## Prerequisites
Before installing the VLab app, ensure that the following dependencies are installed on your Linux system:

- Python
- Git
- Docker

## Installation (Arch Linux)

```bash
paru -S vlab-bin
# OR
yay -S vlab-bin
```

## Installation using Script

To install the VLab app, you can use the provided installation script. Open your terminal and run the following command:

```bash
sudo apt update -y && sudo apt install -y curl && curl https://raw.githubusercontent.com/bodhitree-iitb/vlab-installation/main/ubuntu-install.sh 2> /dev/null | sh
```
- if it ever asks for some permission, give permission press `y` or the key as specified.
- **(Make sure to reboot after this script finishes)**
This command will download and execute the installation script, which takes care of installing Python, Git, Docker, and other necessary components for the VLab app. 


# What if the installation fails?

If the installation script fails, you may need to manually check and install missing dependencies. Here's a step-by-step guide: 
### Installaion commands shown here are for ubuntu (debian)

1. ## Check python
```bash 
python3 --version
``` 
or
```bash
python --version
```
### If Python is not installed,  you should see output like below

![python installed](image.png)

### else output would be like this

![python not installed](image-1.png)

### If not installed you can install it using your package manager. For example, on Ubuntu, you can use:
```bash
sudo apt install python3
```
2. ## Check for git
```bash
git --version
```
### if installed :

![git installed](image-3.png)

### if not installed :

![git not installed](image-2.png)
### If Git is not installed, install it using:
```bash
sudo apt install git
```
3. ## Check docker
```bash
docker --version
```
### if installed :

![docker installed](image-4.png)

### if not installed :

![Alt text](image-5.png))

### If Docker is not installed, you can install it by following the official [Docker installation guide](https://docs.docker.com/desktop/install/linux-install/).

4. ## retry vlab by running previous command
```bash
curl https://raw.githubusercontent.com/bodhitree-iitb/vlab-installation/main/ubuntu-install.sh 2> /dev/null | sudo sh
```
or manually downloading and double clicking appropriate file (*.deb for debian)
[link](https://drive.google.com/drive/folders/1hXk_7kaWA71WSfltraeLEIzKlHs0ns1Z?usp=sharing) (only accessible via iitb google account)

5. ## Electron sandbox issue

Run the following in your terminal

```bash
/opt/Vlab/vlab
```

If you see the error `FATAL:gpu_data_manager_impl_private.cc(445)] GPU process isn't usable`, use the following command to fix the issue

```bash
sudo sed -i 's/\(\/opt\/VLab\/vlab\)/\1 --no-sandbox/g' /usr/share/applications/vlab.desktop
```
