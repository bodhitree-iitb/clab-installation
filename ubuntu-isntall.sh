# Define ANSI escape codes for blue color
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Display progress in blue
echo -e "${BLUE}Updating package lists...${NC}"
apt update

# Check if Docker is already installed
if command -v docker &>/dev/null; then
  echo -e "${BLUE}Docker is already installed.${NC}"
else
  echo -e "${BLUE}Docker is not installed. Installing...${NC}"

  # Update the package index
  apt update

  # Install packages to allow apt to use a repository over HTTPS
  apt install -y apt-transport-https ca-certificates curl software-properties-common

  # Add Docker’s official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # Set up the stable Docker repository
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Update the package index again
  apt update

  # Install the latest version of Docker
  apt install -y docker-ce docker-ce-cli containerd.io

  # Create Docker group if it doesn't exist
  if ! getent group docker > /dev/null 2>&1; then
    echo -e "${BLUE}Creating Docker group...${NC}"
    groupadd docker
  fi

  # Add the current user to the Docker group
  echo -e "${BLUE}Adding the current user to the Docker group...${NC}"
  usermod -aG docker $USER

  # Display instructions to logout and log in again
  echo -e "${BLUE}Docker has been successfully installed. Please restart your shell to apply the group changes.${NC}"
fi

# Display in blue
echo -e "${BLUE}Installing curl and wget...${NC}"
apt install -y curl wget

# Download the Debian package
echo -e "${BLUE}Downloading the Debian package...${NC}"
wget https://bighome.iitb.ac.in/index.php/s/jBnqDiadf2abatS/download/VLab_1.5.4_amd64.deb

# Install the downloaded Debian package using dpkg
echo -e "${BLUE}Installing the downloaded Debian package...${NC}"
dpkg -i VLab_1.5.4_amd64.deb

# Install dependencies (if any)
echo -e "${BLUE}Installing dependencies...${NC}"
apt install -fy

# Install additional packages
echo -e "${BLUE}Installing Python3, Git, and Docker...${NC}"
apt install -y python3 git docker.io

# Cleanup downloaded Debian package
echo -e "${BLUE}Cleaning up...${NC}"
rm VLab_1.5.4_amd64.deb

# Enable Docker service
echo -e "${BLUE}Enabling Docker service...${NC}"
systemctl enable docker

# Display completion message
echo -e "${BLUE}Installation complete.${NC}"
