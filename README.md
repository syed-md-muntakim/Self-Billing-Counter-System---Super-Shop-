# 🛒 Self-Billing Counter System - Super-Shop
> A supermarket self-billing counter built in **8086 Assembly Language** using the EMU8086 emulator.

---

## 📌 About

A self-billing counter system for a super shop built in 8086 assembly language (CISC). Supports member registration and login, non-member shopping, admin product control, cart-based product scanning, automatic bill generation, cash payment with change, loyalty points, and purchase history — all through a text-based menu interface.

---

## ⚙️ Software & Platform

| Item | Detail |
|---|---|
| Emulator | [EMU8086](https://emu8086-microprocessor-emulator.en.softonic.com/) |
| Architecture | x86 CISC 16-bit |
| Memory Model | Small |
| Language | Assembly |

---

## 👥 Users

| User | Access |
|---|---|
| **Member** | Login with phone number, earn and use loyalty points, view own history |
| **Non-Member** | Shop without registration, no points |
| **Admin** | Password protected, manage products, view all history |

---

## ✨ Features

- **Member Registration** — Register with name + 10-digit phone (used as login ID)
- **Member Login** — Login with phone, see points balance
- **Non-Member Shopping** — Cart and billing without login
- **Admin Panel** — Password login, update stock, add new products, view all history
- **Product Listing** — Shows ID, name, price, stock and availability status
- **Product Scanning** — Type 3-digit product ID to add to cart, `000` to finish
- **Cart System** — Stack-based cart, up to 15 items
- **Bill Generation** — Itemised bill with line totals and grand total
- **Loyalty Points** — Members earn `Total/100` points per purchase, redeemable as BDT discount
- **Cash Payment** — Enter cash (multiple of 100), auto-calculates change
- **Purchase History** — Members see own history, admin sees all including guest transactions

---

## 🗂️ Default Data

### Products (5 pre-loaded)
| ID | Name | Price (BDT) | Stock |
|---|---|---|---|
| 101 | Rice | 100 | 50 |
| 102 | Oil | 150 | 30 |
| 103 | Sugar | 100 | 40 |
| 104 | Salt | 50 | 100 |
| 105 | Flour | 200 | 20 |

### Members (5 pre-loaded)
| Phone (ID) | Name | Points |
|---|---|---|
| 0171234567 | Alice | 50 |
| 0181234567 | Bob | 20 |
| 0191234567 | Carol | 0 |
| 0155555555 | David | 100 |
| 0166666666 | Eve | 30 |

**Admin Password:** `1234`

---

## 🕹️ How to Use

```
Main Menu → press 1, 2, 3, 4 or 5 (no Enter needed)

Scanning   → type exactly 3 digits for product ID (e.g. 101)
             type 000 to finish scanning and generate bill

Quantity   → type exactly 2 digits (e.g. 01, 05, 10)

Password   → type exactly 4 digits (e.g. 1234)

Phone      → type all 10 digits, auto-proceeds (e.g. 0171234567)

Cash       → type exactly 5 digits (e.g. 05000 for BDT 5000)

Y/N prompt → press Y or any other key (no Enter needed)
```

---

## 🧠 Key Concepts

| **Macros** | **Procedures** | **Stack** | **Arrays** | **Branching** | **Loop** | **Sentinel** | **INT 21h** |
|---|---|---|---|---|---|---|---|

---

## ⚠️ Limitations

Some limitations are set intentionally for feature development. 

| Issue | Detail |
|---|---|
| No disk save | All data resets when program exits — arrays are in-memory only |
| 16-bit limit | Max cash input is 32700 BDT due to 16-bit word overflow |
| Max capacity | 10 members, 10 products, 15 cart items, 20 member history entries |
| Phone strict | Phone must be exactly 10 digits — will retry on wrong input |
| Price input | Admin price must be a multiple of 5, typed as 5 digits (e.g. `00100` for 100 BDT) |
| EMU8086 only | Will not assemble correctly in TASM/MASM without minor adjustments (LOCAL macro labels) |
| No backspace | Fixed-digit inputs have no backspace support — a wrong digit requires restarting that input |

---

## 🚀 How to Run

**Step 1** — Install [EMU8086](https://emu8086-microprocessor-emulator.en.softonic.com/)

**Step 2** — Download `Self-Billing Counter System.asm`

**Step 3** — Open `Self-Billing Counter System.asm` with EMU8086

**Step 4** — Press `💾 save` to Save (to be safe)

**Step 5** — Press `▷ emulate` to Assemble

**Step 6** — Press `≫ run` to Run

---

## 📜 License

Academic purposes only.
