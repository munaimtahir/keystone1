#!/bin/bash
set -e

echo "=========================================="
echo "Keystone Setup and Deployment Script"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/munaimtahir/keystone"
KEystone_DIR="/home/munaim/keystone/apps/keystone"
TEMP_DIR="/tmp/keystone-clone-$$"

echo -e "${YELLOW}Step 1: Cloning repository...${NC}"
cd /home/munaim/keystone/apps
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi
git clone "$REPO_URL" "$TEMP_DIR"

echo -e "${YELLOW}Step 2: Copying platform directory...${NC}"
if [ ! -d "$KEystone_DIR/platform" ]; then
    mkdir -p "$KEystone_DIR/platform"
fi

# Copy platform directory contents
cp -r "$TEMP_DIR/platform"/* "$KEystone_DIR/platform/"

echo -e "${YELLOW}Step 3: Cleaning up temporary directory...${NC}"
rm -rf "$TEMP_DIR"

echo -e "${YELLOW}Step 4: Verifying source code...${NC}"
cd "$KEystone_DIR"

if [ -f "platform/backend/manage.py" ]; then
    echo -e "${GREEN}✓ Backend source code found${NC}"
else
    echo -e "${RED}✗ Backend source code missing!${NC}"
    exit 1
fi

if [ -f "platform/frontend/package.json" ]; then
    echo -e "${GREEN}✓ Frontend source code found${NC}"
else
    echo -e "${RED}✗ Frontend source code missing!${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 5: Verifying configuration...${NC}"
if [ ! -f ".env" ]; then
    echo "Creating .env from env.example..."
    cp env.example .env
    # Update HOST_RUNTIME_PATH if not already set
    if ! grep -q "HOST_RUNTIME_PATH" .env; then
        echo "HOST_RUNTIME_PATH=/home/munaim/keystone/apps/keystone/runtime" >> .env
    fi
fi

# Ensure HOST_RUNTIME_PATH is correct
sed -i 's|HOST_RUNTIME_PATH=.*|HOST_RUNTIME_PATH=/home/munaim/keystone/apps/keystone/runtime|' .env
echo -e "${GREEN}✓ Configuration verified${NC}"

echo -e "${YELLOW}Step 6: Ensuring runtime directories exist...${NC}"
mkdir -p runtime/repos runtime/logs
chmod -R 755 runtime/
echo -e "${GREEN}✓ Runtime directories ready${NC}"

echo -e "${YELLOW}Step 7: Stopping any existing containers...${NC}"
docker compose down 2>/dev/null || true

echo -e "${YELLOW}Step 8: Building and deploying Keystone...${NC}"
docker compose up -d --build

echo ""
echo -e "${GREEN}=========================================="
echo "Deployment Complete!"
echo "==========================================${NC}"
echo ""
echo "Keystone is now running. Check status with:"
echo "  docker compose ps"
echo ""
echo "View logs with:"
echo "  docker compose logs -f"
echo ""
echo "Access Keystone UI at:"
echo "  http://$(hostname -I | awk '{print $1}')"
echo ""
echo "Traefik Dashboard (localhost only):"
echo "  http://localhost:8080"
echo ""

