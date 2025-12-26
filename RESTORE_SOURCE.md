# Restore Keystone Source Code

## Status

The directory structure and configuration files are ready, but the Keystone source code needs to be restored to the `platform/` directory.

## Required Source Code Structure

After restoration, you should have:

```
apps/keystone/platform/
├── backend/
│   ├── api/              # Django API app
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── serializers.py
│   │   └── migrations/
│   ├── keystone/         # Django project settings
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── wsgi.py
│   ├── manage.py
│   ├── requirements.txt
│   └── Dockerfile
└── frontend/
    ├── src/              # React source code
    │   ├── App.jsx
    │   ├── components/
    │   └── api.js
    ├── package.json
    ├── vite.config.js
    └── Dockerfile
```

## Restoration Options

### Option 1: Restore from Backup

If you have a backup of the Keystone source code:

```bash
cd /home/munaim/keystone/apps/keystone
# Restore platform/ directory from your backup
# Ensure it contains backend/ and frontend/ subdirectories
```

### Option 2: Clone from Git Repository

If you have the Git repository URL:

```bash
cd /home/munaim/keystone/apps/keystone
git clone <repository-url> temp-keystone
mv temp-keystone/platform/* platform/
rm -rf temp-keystone
```

### Option 3: Copy from Development Location

If you have the source code in another location:

```bash
# Example: if source is in ~/backup/keystone/platform/
cp -r ~/backup/keystone/platform/* /home/munaim/keystone/apps/keystone/platform/
```

## Verification

After restoring, verify the source code:

```bash
cd /home/munaim/keystone/apps/keystone

# Check backend
test -f platform/backend/manage.py && echo "✓ Backend OK" || echo "✗ Backend missing"
test -f platform/backend/requirements.txt && echo "✓ Requirements OK" || echo "✗ Requirements missing"

# Check frontend
test -f platform/frontend/package.json && echo "✓ Frontend OK" || echo "✗ Frontend missing"
test -d platform/frontend/src && echo "✓ Frontend src OK" || echo "✗ Frontend src missing"
```

## Next Steps After Restoration

1. **Verify source code is complete** (see above)
2. **Deploy Keystone:**
   ```bash
   cd /home/munaim/keystone/apps/keystone
   docker compose up -d --build
   ```
3. **Access Keystone UI** at http://YOUR_VPS_IP

## Current Configuration Status

✅ Directory structure created
✅ docker-compose.yml configured with correct paths
✅ .env file created with HOST_RUNTIME_PATH set
✅ Runtime directories initialized
✅ Documentation created

⏳ Source code needs to be restored to platform/

