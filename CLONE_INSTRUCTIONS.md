# How to Clone Keystone from GitHub

## Recommended Approach

Since you already have configuration files (docker-compose.yml, .env) in this directory, clone to a temporary location and copy only the `platform/` directory.

## Step-by-Step Instructions

### Option 1: Clone to Temp and Copy Platform (RECOMMENDED)

```bash
# Navigate to apps directory
cd /home/munaim/keystone/apps

# Clone to temporary location
git clone <your-keystone-github-url> keystone-temp

# Copy only the platform directory (preserves your config files)
cp -r keystone-temp/platform/* keystone/platform/

# Clean up temp directory
rm -rf keystone-temp

# Verify platform directory has content
ls -la keystone/platform/backend/
ls -la keystone/platform/frontend/
```

### Option 2: Clone Directly (Overwrites Config Files)

**⚠️ WARNING: This will overwrite your docker-compose.yml and .env files!**

```bash
cd /home/munaim/keystone/apps

# Remove existing keystone directory
rm -rf keystone

# Clone fresh
git clone <your-keystone-github-url> keystone

# Restore your .env file (if you had custom settings)
# You'll need to recreate .env from env.example
cd keystone
cp env.example .env
# Edit .env with your settings
nano .env
```

## After Cloning

1. **Verify source code is present:**
   ```bash
   cd /home/munaim/keystone/apps/keystone
   test -f platform/backend/manage.py && echo "✓ Backend OK" || echo "✗ Backend missing"
   test -f platform/frontend/package.json && echo "✓ Frontend OK" || echo "✗ Frontend missing"
   ```

2. **Update .env if needed:**
   ```bash
   nano .env
   # Ensure HOST_RUNTIME_PATH=/home/munaim/keystone/apps/keystone/runtime
   ```

3. **Deploy:**
   ```bash
   docker compose up -d --build
   ```

## Directory Structure After Cloning

```
/home/munaim/keystone/apps/keystone/
├── platform/              ← Source code from GitHub
│   ├── backend/          ← Django API
│   └── frontend/         ← React UI
├── runtime/              ← Already set up
├── docker-compose.yml     ← Already configured
├── .env                  ← Already created
└── env.example           ← Template
```

## GitHub Repository URL Format

Replace `<your-keystone-github-url>` with your actual repository URL:
- HTTPS: `https://github.com/username/keystone.git`
- SSH: `git@github.com:username/keystone.git`

