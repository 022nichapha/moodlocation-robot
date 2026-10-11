# 🧪 MoodLocation Automated E2E Testing (Robot Framework)

โครงการทดสอบระบบอัตโนมัติแบบ End-to-End (E2E) สำหรับเว็บแอปพลิเคชัน [MoodLocation](https://moodlocation.vercel.app/) โดยใช้ **Robot Framework** และ **SeleniumLibrary** เพื่อทดสอบฟังก์ชันหลักตาม User Story: **US-02 การเลือกอารมณ์และค้นหาสถานที่ตามประเภทสถานที่**

## 📌 สารบัญ

- [โครงสร้างโปรเจกต์](#-โครงสร้างโปรเจกต์)
- [ความต้องการของระบบ](#-ความต้องการของระบบ)
- [การติดตั้ง](#-การติดตั้ง)
- [การตั้งค่า Environment Variables](#-การตั้งค่า-environment-variables)
- [การรันทดสอบ](#-การรันทดสอบ)
- [รายละเอียด Test Cases](#-รายละเอียด-test-cases)
- [การดูผลการทดสอบ](#-การดูผลการทดสอบ)
- [การแก้ปัญหาเบื้องต้น](#-การแก้ปัญหาเบื้องต้น)

## 📁 โครงสร้างโปรเจกต์

```text
moodlocation-robot/
├── .venv/                   # Python Virtual Environment
├── results/                 # Test Reports, Logs และ Screenshots
├── tests_us02.robot         # สคริปต์ทดสอบ US-02
└── README.md                # คู่มือการใช้งาน
```

> ไม่ควรอัปโหลด `.venv/`, ไฟล์รายงานที่มีข้อมูลส่วนตัว หรือไฟล์ที่เก็บรหัสผ่านขึ้น GitHub

## 🛠️ ความต้องการของระบบ

ก่อนเริ่มใช้งาน ควรติดตั้งโปรแกรมดังต่อไปนี้

- Python 3.8 ขึ้นไป
- Google Chrome
- Robot Framework
- SeleniumLibrary
- ChromeDriver ที่เข้ากันได้กับ Chrome หรือ Selenium Manager ที่สามารถจัดการไดรเวอร์ให้อัตโนมัติได้

## 📥 การติดตั้ง

### 1. เปิด Terminal และเข้าโฟลเดอร์โปรเจกต์

Windows CMD:

```bat
cd /d "C:\Users\นิชาภา\Desktop\moodlocation-robot"
```

### 2. เปิดใช้งาน Virtual Environment

Windows CMD:

```bat
.venv\Scripts\activate
```

Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

### 3. ติดตั้งไลบรารี

```bash
pip install robotframework robotframework-seleniumlibrary
```

ตรวจสอบเวอร์ชันที่ติดตั้ง:

```bash
robot --version
```

## 🔐 การตั้งค่า Environment Variables

สคริปต์ต้องใช้บัญชีทดสอบเพื่อเข้าสู่ระบบ โดยกำหนดอีเมลและรหัสผ่านผ่าน Environment Variables

**Windows CMD**

```bat
set MOOD_EMAIL=nichaphabeam2548@gmail.com
set MOOD_PASSWORD=Beam160448.
```

**Windows PowerShell**

```powershell
$env:MOOD_EMAIL="your_email@mail.com"
$env:MOOD_PASSWORD="your_password"
```

เปลี่ยนค่าเป็นบัญชีทดสอบของคุณ และอย่าเผยแพร่รหัสผ่านใน README หรือ GitHub

> ค่าที่กำหนดด้วย `set` ใน CMD จะใช้ได้เฉพาะหน้าต่าง Terminal นั้น และควรกำหนดใหม่เมื่อเปิดหน้าต่างใหม่

## 🚀 การรันทดสอบ

ตรวจสอบก่อนว่าเปิด Virtual Environment แล้ว และกำหนด Environment Variables เรียบร้อยแล้ว

### 1. รันทดสอบทั้งหมด

```bash
robot --outputdir results tests_us02.robot
```

### 2. รันเฉพาะ Test Case

ทดสอบเลือกอารมณ์เครียด:

```bash
robot --outputdir results --test "TC_2_0_001 เลือกอารมณ์เครียดและค้นหาสถานที่" tests_us02.robot
```

ทดสอบเปลี่ยนอารมณ์เป็นมีความสุข:

```bash
robot --outputdir results --test "TC_2_0_002 เปลี่ยนอารมณ์เป็นมีความสุขและค้นหาสถานที่" tests_us02.robot
```

## 🧪 รายละเอียด Test Cases

| Test Case ID | ชื่อการทดสอบ | ขั้นตอนหลัก | ผลลัพธ์ที่คาดหวัง |
|---|---|---|---|
| TC_2_0_001 | เลือกอารมณ์เครียดและค้นหาสถานที่ | เข้าสู่ระบบ → เลือกอารมณ์เครียด → เลือกประเภทสถานที่ → ค้นหา → เปิดรายละเอียด | ระบบแสดงผลสถานที่และเปิดรายละเอียดได้ |
| TC_2_0_002 | เปลี่ยนอารมณ์เป็นมีความสุขและค้นหาสถานที่ | เข้าสู่ระบบ → ค้นหาด้วยอารมณ์เครียด → ย้อนกลับ → เลือกมีความสุข → ค้นหาอีกครั้ง | ระบบสามารถเปลี่ยนอารมณ์และแสดงผลการค้นหาใหม่ได้ |

หมายเหตุ: ขั้นตอนและผลลัพธ์ที่คาดหวังต้องสอดคล้องกับการทำงานจริงของเว็บไซต์ หากหน้าจอหรือข้อความปุ่มเปลี่ยนแปลง ควรปรับ Locator ใน `tests_us02.robot` ให้ตรงกับหน้าเว็บปัจจุบัน

## 📊 การดูผลการทดสอบ

เมื่อรันทดสอบด้วย `--outputdir results` ระบบจะสร้างไฟล์รายงานไว้ในโฟลเดอร์ `results/`

| ไฟล์ | รายละเอียด |
|---|---|
| `report.html` | สรุปผล Pass/Fail และระยะเวลาทดสอบ |
| `log.html` | รายละเอียดแต่ละ Keyword และขั้นตอนการทดสอบ |
| `output.xml` | ผลการทดสอบรูปแบบ XML สำหรับประมวลผลต่อ |
| Screenshots | ภาพหน้าจอที่สคริปต์บันทึกไว้ หากมีการกำหนด Capture Page Screenshot |

เปิด `report.html` หรือ `log.html` ด้วยเว็บเบราว์เซอร์เพื่อดูรายละเอียด

## 💡 การแก้ปัญหาเบื้องต้น

### 1. ElementClickInterceptedException

**สาเหตุ:** มีองค์ประกอบอื่น เช่น Navbar หรือ Overlay บังตำแหน่งคลิก

**แนวทางแก้ไข:** เลื่อน Element ให้อยู่ในตำแหน่งที่เหมาะสมก่อนคลิก และตรวจสอบว่าไม่มี Overlay บังอยู่ หากจำเป็นอาจใช้ JavaScript Click เป็นทางเลือก แต่ต้องตรวจสอบด้วยว่าการคลิกเกิดขึ้นได้จริงตามพฤติกรรมผู้ใช้

### 2. Element ไม่พบหรือไม่แสดง

**สาเหตุ:** XPath ไม่ตรงกับ HTML จริง, Element ยังโหลดไม่เสร็จ หรือมี Element ซ้ำสำหรับหน้าจอขนาดต่างกัน

**แนวทางแก้ไข:**

- ตรวจสอบ HTML และข้อความของปุ่มจากหน้าเว็บจริง
- ใช้ `Wait Until Element Is Visible` แทนการรอด้วย `Sleep` เพียงอย่างเดียว
- เลือก Element ที่มองเห็นและสามารถโต้ตอบได้จริง

### 3. Timeout หลังเลือกอารมณ์

**สาเหตุ:** เว็บไซต์ยังโหลดข้อมูล หรือสคริปต์คาดหวังปุ่มจากขั้นตอนถัดไปก่อนที่หน้าเว็บจะเปลี่ยน

**แนวทางแก้ไข:** บันทึก Screenshot หลังเลือกอารมณ์ และตรวจสอบ Element ที่แสดงจริงก่อนเขียนขั้นตอนค้นหาต่อ

### 4. ไม่พบ MOOD_EMAIL หรือ MOOD_PASSWORD

**สาเหตุ:** ยังไม่ได้กำหนด Environment Variables หรือเปิด Terminal ใหม่

**แนวทางแก้ไข:** กำหนดตัวแปรในหน้าต่าง CMD เดียวกับที่ใช้รันทดสอบ แล้วรันใหม่

### 5. Chrome เปิดไม่ได้

**สาเหตุ:** ปัญหาการติดตั้ง Chrome หรือ WebDriver

**แนวทางแก้ไข:** ตรวจสอบ Chrome และ SeleniumLibrary เวอร์ชันที่ติดตั้ง รวมถึงการทำงานของ Selenium Manager หรือ ChromeDriver

---

**Project:** MoodLocation Automated E2E Testing  
**Framework:** Robot Framework  
**Browser Automation:** SeleniumLibrary  
**Application:** [https://moodlocation.vercel.app/](https://moodlocation.vercel.app/)  
**Test Scope:** User Story US-02 — การเลือกอารมณ์และค้นหาสถานที่
