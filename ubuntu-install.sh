# Define ANSI escape codes for blue color
BLUE='\033[0;34m'
NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'

# Display progress in blue
echo -e "${BLUE}Updating package lists...${NC}"
sudo apt update

echo -e "${BLUE}Installing Docker...${NC}"

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create Docker group if it doesn't exist
if ! getent group docker > /dev/null 2>&1; then
  echo -e "${BLUE}Creating Docker group...${NC}"
  sudo groupadd docker
fi

# Add the current user to the Docker group
echo -e "${BLUE}Adding the current user to the Docker group...${NC}"
sudo usermod -aG docker $USER

# Display in blue
echo -e "${BLUE}Installing curl and wget...${NC}"
sudo apt install -y curl wget

# Download the Debian package
echo -e "${BLUE}Downloading the Debian package...${NC}"
wget https://github.com/bodhitree-iitb/clab-installation/releases/download/v1.5.5/VLab_1.5.5_amd64.deb

# Install the downloaded Debian package using dpkg
echo -e "${BLUE}Installing the downloaded Debian package...${NC}"
sudo dpkg -i VLab_1.5.4_amd64.deb

# Install dependencies (if any)
echo -e "${BLUE}Installing dependencies...${NC}"
sudo apt install -fy

# Install additional packages
echo -e "${BLUE}Installing Python3, Git, and Docker...${NC}"
sudo apt install -y python3 git docker.io python-is-python3

# Cleanup downloaded Debian package
echo -e "${BLUE}Cleaning up...${NC}"
rm VLab_1.5.4_amd64.deb

# Enable Docker service
echo -e "${BLUE}Enabling Docker service...${NC}"
sudo systemctl enable docker

# Display completion message
echo -e "${BLUE}Installation complete.${NC}"

# Display instructions to logout and log in again
echo -e "\n\n\n${GREEN}Vlab has been successfully installed.\n\n${RED}Please restart to finish installation.${NC}"
