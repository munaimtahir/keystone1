# Keystone Deployment Information

## ✅ Deployment Status: ACTIVE

**Deployment Date:** $(date)
**Public IP:** 34.87.144.205

## 🌐 Access URLs

### Keystone Panel (Main UI)
- **URL:** http://34.87.144.205
- **Login:** admin / admin (change in .env)
- **Status:** ✅ Running

### Traefik Dashboard (Localhost Only)
- **URL:** http://localhost:8080
- **Note:** Only accessible from the VPS itself for security

### API Endpoint
- **URL:** http://34.87.144.205/api
- **Status:** ✅ Running

## 📊 Container Status

All containers are running:

- ✅ **keystone-traefik** - Reverse proxy (port 80)
- ✅ **keystone-backend** - Django API (port 8000)
- ✅ **keystone-frontend** - React UI (port 80)
- ✅ **keystone-db** - PostgreSQL database (healthy)

## 🔧 Management Commands

### View Status
```bash
cd /home/munaim/keystone/apps/keystone
docker compose ps
```

### View Logs
```bash
# All logs
docker compose logs -f

# Specific service
docker compose logs -f backend
docker compose logs -f frontend
```

### Stop Services
```bash
docker compose down
```

### Restart Services
```bash
docker compose restart
```

### Update and Redeploy
```bash
cd /home/munaim/keystone/apps/keystone
git pull  # If using git
docker compose up -d --build
```

## 🔒 Security Notes

1. **Change Default Password:** Update `KEYSTONE_ADMIN_PASSWORD` in `.env`
2. **Change Secret Key:** Update `DJANGO_SECRET_KEY` in `.env`
3. **Firewall:** Port 80 is open and accessible
4. **HTTPS:** Consider setting up HTTPS with Let's Encrypt (future)

## 📁 Important Paths

- **Configuration:** `/home/munaim/keystone/apps/keystone/.env`
- **Source Code:** `/home/munaim/keystone/apps/keystone/platform/`
- **Runtime Data:** `/home/munaim/keystone/apps/keystone/runtime/`
- **Logs:** `/home/munaim/keystone/apps/keystone/runtime/logs/`

## 🚀 Next Steps

1. **Access Keystone UI:** http://34.87.144.205
2. **Login:** Use admin credentials from `.env`
3. **Import Repositories:** Add GitHub repositories through the UI
4. **Deploy Apps:** Use the 3-step workflow (Import → Prepare → Deploy)

## 📝 Troubleshooting

### If Keystone is not accessible:

1. **Check containers:**
   ```bash
   docker compose ps
   ```

2. **Check logs:**
   ```bash
   docker compose logs
   ```

3. **Check firewall:**
   ```bash
   sudo ufw status
   ```

4. **Restart services:**
   ```bash
   docker compose restart
   ```

### Verify Public IP Access

From your local machine:
```bash
curl http://34.87.144.205
```

You should see the Keystone frontend HTML.

