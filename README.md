# 🌐 Azure Storage Account & VM-Based Static Website Deployment

![Image](https://miro.medium.com/1%2A8RE4treRCOnLeFsSlHZxrw.png)

![Image](https://miro.medium.com/1%2AehEQFicUBQ85Yri5kEy4jA.png)

![Image](https://ochzhen.com/assets/img/azure-custom-script-extension-windows/uploaded-custom-script.png)

![Image](https://www.c-sharpcorner.com/article/adding-custom-script-extension-in-azure-virtual-machine/Images/Adding%20Custom%20Script%20Extension%20In%20Azure%20Virtual%20Machine.jpg)

---

## 📌 Project Title

**Deploying a Static Website Using Azure Storage Blob & Linux VM (Apache)**

---

## 📖 Overview

This project demonstrates **two Azure-based static website approaches combined**:

1. **Azure Blob Storage** for hosting static assets (HTML, images, scripts)
2. **Azure Linux Virtual Machine** running **Apache Web Server** to serve a website
3. VM loads **images and assets directly from Azure Blob Storage**
4. Optional: Azure **Static Website Hosting** feature (without VM)

---

## 🎯 Objectives

* Understand Azure Storage Accounts & Blob Containers
* Deploy Apache web server automatically using **Custom Script**
* Enable **anonymous Blob access**
* Serve **static content from Blob Storage** inside a VM-hosted website
* Learn **real-world hybrid architecture** (VM + Storage)

---

## 🏗 Architecture Diagram (Logical Flow)

```
User Browser
     |
     |  HTTP Request
     v
Azure Linux VM (Apache)
     |
     |  Image Request
     v
Azure Blob Storage (Public)
```

---

## 🧰 Prerequisites

* Azure Subscription
* Azure CLI installed
* Resource Group created
* Linux OS knowledge (basic)
* Public IP access enabled on VM

---

## 🚀 Step-by-Step Implementation

---

## 🔹 Step 1: Create Azure Storage Account

```bash
az storage account create \
  --name <your-storage-account-name> \
  --resource-group <your-resource-group> \
  --location <location> \
  --sku Standard_LRS
```

📌 **Purpose**: Stores static assets like scripts, HTML, images.

---

## 🔹 Step 2: Create Blob Container

```bash
az storage container create \
  --name mycontainer \
  --account-name <your-storage-account-name>
```

📌 **Container** is similar to a folder inside Blob Storage.

---

## 🔹 Step 3: Prepare Apache Installation Script (`script.sh`)

```bash
#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
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

📌 **What this script does**:

* Installs Apache
* Starts Apache service
* Creates default `index.html`
* Enables website on VM boot

---

## 🔹 Step 4: Upload Script to Azure Blob Storage

```bash
az storage blob upload \
  --account-name <your-storage-account-name> \
  --container-name mycontainer \
  --file script.sh \
  --name script.sh
```

📌 Script is now stored centrally and reusable.

---

## 🔹 Step 5: Create Azure Linux VM with Custom Script

1. Go to **Azure Portal**
2. Navigate to **Virtual Machines → Create**
3. Choose:

   * Image: Ubuntu 20.04 / 22.04
   * Size: Standard B1s (for demo)
4. Go to **Advanced → Custom Data**
5. Upload `script.sh`
6. Create VM

📌 Script runs **automatically on first boot**.

---

## 🔹 Step 6: Access Website Using VM Public IP

```text
http://<VM-PUBLIC-IP>
```

✅ Output:

```
Hello World
```

---

## 🔐 Step 7: Enable Anonymous Access for Blob Storage

### Storage Account Level

* Storage Account → **Configuration**
* Enable: **Allow Blob anonymous access**

### Container Level

* Storage Account → Containers → `mycontainer`
* Change access level to:

  ```
  Blob (anonymous read access)
  ```

📌 Required to serve images publicly.

---

## 🖼 Step 8: Load Image from Blob Storage into VM Website

### Upload Image

```bash
az storage blob upload \
  --account-name <your-storage-account-name> \
  --container-name mycontainer \
  --file cat.webp \
  --name cat.webp
```

---

### Update VM `index.html`

```bash
cd /var/www/html
sudo nano index.html
```

```html
<html>
<head>
    <title>My Static Website</title>
</head>
<body>
    <h1 style="text-align: center;">Welcome to My Static Website!</h1>

    <div style="text-align: center;">
        <img src="https://<storage-account-name>.blob.core.windows.net/mycontainer/cat.webp" alt="Image from Blob">
    </div>
</body>
</html>
```

🔄 Reload browser → Image loads from Blob Storage 🎉

---

## 🔗 Example Blob URL

```text
https://atulkamble9796857478.blob.core.windows.net/mycontainer/cat.webp
```

---

## 🌍 Optional: Azure Static Website Hosting (Without VM)

Azure Storage can **host websites directly**.

### Enable Static Website

1. Storage Account → **Static website**
2. Enable
3. Set:

   * Index document: `index.html`
   * Error document: `404.html`

---

### Static Website URL

```text
https://<storage-account-name>.z13.web.core.windows.net/
```

Example:

```
https://atulkamble9796857478.z13.web.core.windows.net/
```

📌 Paste Blob image URLs inside `index.html`.

---

## 📊 Comparison: VM vs Blob Static Website

| Feature         | VM + Apache           | Blob Static Website      |
| --------------- | --------------------- | ------------------------ |
| Server required | ✅ Yes                 | ❌ No                     |
| Cost            | Higher                | Very Low                 |
| Scaling         | Manual                | Automatic                |
| OS Control      | Full                  | None                     |
| Best For        | Learning, legacy apps | Static sites, portfolios |

---

## 🧠 Key Learnings

* Azure Storage is **not just storage**
* Blob Storage can act as a **CDN-like asset server**
* Custom scripts automate VM provisioning
* Static Website feature eliminates VM cost
* Common interview + production scenario

---

## 📌 Use Cases

* DevOps Labs
* Training Projects
* Portfolio Websites
* Image hosting
* Cost-optimized static apps
* Interview demonstrations

---

## 🏁 Conclusion

This project demonstrates a **real-world Azure hybrid deployment**, combining:

* **Compute (VM)**
* **Storage (Blob)**
* **Automation (Custom Script)**
* **Security (Anonymous access control)**

It is **beginner-friendly**, **interview-ready**, and **production-relevant**.

---
