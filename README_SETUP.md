# Keystone Setup Instructions

## Current Status

The directory structure has been set up, but the Keystone source code needs to be restored/cloned.

## Required: Restore Keystone Source Code

You have two options:

### Option 1: Clone from Git Repository

```bash
cd /home/munaim/keystone/apps/keystone
git clone <your-keystone-repo-url> .
# Or if cloning to a subdirectory:
# git clone <your-keystone-repo-url> temp && mv temp/* . && rmdir temp
```

### Option 2: Restore from Backup

```bash
cd /home/munaim/keystone/apps
# Restore keystone directory from your backup
# Ensure it contains:
#   - platform/ (with backend/ and frontend/)
#   - docker-compose.yml (already created with correct paths)
#   - env.example (already created)
#   - Other source files
```

## Required Files/Directories

After restoring, you should have:

```
apps/keystone/
├── platform/
│   ├── backend/          # Django API source code
│   │   ├── api/
│   │   ├── keystone/
│   │   ├── manage.py
│   │   └── requirements.txt
│   └── frontend/         # React UI source code
│       ├── src/
│       ├── package.json
│       └── Dockerfile
├── docker-compose.yml    # ✅ Already created
├── env.example           # ✅ Already created
└── runtime/              # ✅ Already created
    ├── repos/
    └── logs/
```

## Next Steps

1. **Restore/Clone Source Code** (see above)
2. **Configure Environment:**
   ```bash
   cd /home/munaim/keystone/apps/keystone
   cp env.example .env
   nano .env  # Edit with your settings
   ```
3. **Deploy:**
   ```bash
   docker compose up -d --build
   ```

## Configuration Notes

- `HOST_RUNTIME_PATH` in `docker-compose.yml` is already set to: `/home/munaim/keystone/apps/keystone/runtime`
- Runtime directories (`repos/`, `logs/`) are already initialized
- All paths are configured for the standardized structure

## Verification

After restoring source code, verify:

```bash
cd /home/munaim/keystone/apps/keystone
ls -la platform/backend/  # Should show Django files
ls -la platform/frontend/ # Should show React files
test -f platform/backend/manage.py && echo "✓ Backend OK" || echo "✗ Backend missing"
test -f platform/frontend/package.json && echo "✓ Frontend OK" || echo "✗ Frontend missing"
```

