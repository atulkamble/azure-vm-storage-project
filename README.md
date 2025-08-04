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
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
cd /var/www/html 
sudo chmod 755 /var/www/html
sudo tee index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
</head>
<body>
    <h1 style="text-align: center;">Hello World</h1>
</body>
</html>
EOF
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
        <img src="https://<your-storage-account-name>.blob.core.windows.net/mycontainer/cat.jpg" alt="Cat">
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
# Static Website Hosting 

Data Management 
static website setting 

>> web >> index.html (paste blob url)
```
example: https://atulkamble9796857478.z13.web.core.windows.net/
```
