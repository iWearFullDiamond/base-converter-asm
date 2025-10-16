# 🔢 Decimal → Base 2..36 Converter (x86 Assembly, 16-bit MASM/TASM)

This program converts a decimal number (0 – 65,535) to any base between **2 and 36**, written entirely in **x86 Assembly (16-bit)**.  
It was assembled and executed using the **MASM/TASM extension in VS Code**, without external emulators.

---

## 🧠 Overview
The algorithm performs **repeated integer division** by the chosen base and stores each remainder on the stack.  
After all divisions, it pops the remainders in reverse order to display the converted number correctly.

Characters `0–9` and lowercase `a–z` represent digits for bases > 10.

This project demonstrates:
- Low-level register manipulation and arithmetic  
- Stack operations (`PUSH`, `POP`) for digit reversal  
- Integer division (`DIV CX`) and remainder handling  
- Character encoding and ASCII arithmetic  
- Console I/O through **INT 21h** BIOS interrupts  

---

## 🧰 Technologies Used
- **x86 Assembly (16-bit)**  
- **MASM/TASM syntax**  
- **VS Code MASM/TASM extension** for building and running  
- **INT 21h** for input and output  

---

## ▶️ How to Build and Run in VS Code
1. Install the **MASM/TASM extension** (e.g. *MASM/TASM for VS Code*).  
2. Open this project folder in VS Code.  
3. In the extension panel, select **Assemble & Run** or press the assigned shortcut.  
4. When prompted in the console:
   - Enter a decimal number (0–65535)  
   - Enter a base (2–36)  
5. The converted value will appear immediately.

---

## 🖥️ Code Structure
src/base_converter_2_36.asm      ; main program
.vscode/tasks.json               ; optional VS Code build task
.gitignore
LICENSE
README.md

---

## 📄 Assembly Notes
- Uses the small memory model (.model small, .stack 100h).
- Performs manual input via INT 21h / 01h and output via INT 21h / 02h.
- Implements base validation (2 ≤ base ≤ 36).
- Uses stack-based reversal to print digits in correct order.
- Maps remainders ≥10 to ASCII lowercase letters (a–z).

---

## 👩‍💻 Author
**iWearFullDiamond**<br>
Second-year Informatics Student @ CSIE-ASE<br>
Passionate about low-level programming, cybersecurity, and Linux systems.

---

## 🪪 License
Released under the MIT License
You may freely use, modify, or distribute this program with proper attribution.
