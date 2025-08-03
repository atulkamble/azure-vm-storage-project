Here’s the **README.md** formatted documentation for your Azure Storage + VM project:

---

# Azure Storage Account & VM Static Website Deployment

## Overview

This project demonstrates how to:

1. Create an Azure Storage Account & Blob Container.
2. Upload scripts and assets to Blob Storage.
3. Launch an Azure Linux VM and execute a custom script to deploy a simple Apache-based static website.
4. Update Blob access policies for anonymous use.
5. Serve static content (HTML & Images) on the VM with Blob-hosted assets.

---

## Steps

### 1. Create Azure Storage Account

```bash
az storage account create \
  --name <your-storage-account-name> \
  --resource-group <your-resource-group> \
  --location <location> \
  --sku Standard_LRS
```

### 2. Create Blob Container

```bash
az storage container create \
  --name mycontainer \
  --account-name <your-storage-account-name>
```

### 3. Upload Script to Blob Storage

Prepare your `script.sh` file:

```bash
echo '#!/bin/bash
apt update -y
apt install apache2 git -y
systemctl start apache2
systemctl enable apache2
cd /var/www/html
chmod 755 /var/www/html
touch index.html
echo "hello world" > index.html' > script.sh
```

Upload it to Blob Storage:

```bash
az storage blob upload \
  --account-name <your-storage-account-name> \
  --container-name mycontainer \
  --file script.sh \
  --name script.sh
```

### 4. Launch Azure Linux VM with Custom Script

* Go to **Azure Portal** > **Virtual Machines** > **Create VM**.
* Select **Advanced** tab.
* Under **Custom Data**, upload your `script.sh`.
* Complete VM creation and deploy.

### 5. Access the VM via Public IP

* Go to the **VM Overview** in Azure Portal.
* Copy the **Public IP Address**.
* Open a browser and navigate to: `http://<Public-IP-Address>`
* You should see: `hello world`

### 6. Update Blob Storage Policy for Anonymous Access

1. **Storage Account** > **Settings** > **Configuration**:

   * Set **Allow Blob anonymous access** to **Enabled**.
2. **Data Storage** > **Containers** > **mycontainer**:

   * Click **Change Access Level**.
   * Select **Anonymous Read Access for blobs only**.

### 7. Update index.html to Load Image from Blob Storage

On the VM:

```bash
cd /var/www/html
sudo nano index.html
```

Replace content with:

```html
<html>
<head>
    <title>My Static Website</title>
</head>
<body>
    <h1 style="text-align: center;">Welcome to My Static Website!</h1>

    <div style="text-align: center;">
        <img src="https://<your-storage-account-name>.blob.core.windows.net/mycontainer/cat.webp" alt="Cat">
    </div>
</body>
</html>
```

Save and exit. Now reload your VM's Public IP in the browser. The image will load from Azure Blob Storage.

---

## Example URL

```
https://atulkamble9796857478.blob.core.windows.net/mycontainer/cat.webp
```

---

## Notes

* Ensure your VM NSG allows inbound HTTP (port 80) traffic.
* All blob URLs must be publicly accessible for this to work.
* For production, consider using Azure CDN or Static Web Apps for better performance.

---

Do you want me to also give you **Azure CLI Automation Script (.sh)** for the **entire setup end-to-end**?
