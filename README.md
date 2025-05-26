# sv-memory-verification

A SystemVerilog-based verification environment for validating a memory interface using constrained random stimulus, mailbox communication, and event synchronization.

## 🧠 Project Overview

This project builds a simple yet powerful testbench to verify read/write operations to a memory block. It includes:

- **Transaction Class**
- **Generator**
- **Driver**
- **Monitors**
- **Scoreboard**
- **Interface**

## 🗂 Directory Structure

```text
sv-memory-verification/
├── src/
│   ├── transaction.sv        # Defines transaction structure
│   ├── generator.sv          # Randomizes and sends transactions
│   ├── driver.sv             # Drives signals to DUT
│   ├── monitor1.sv           # Captures pre-read signals
│   ├── monitor2.sv           # Captures post-read signals
│   ├── scoreboard.sv         # Verifies correctness
│   ├── env.sv                # Environment connecting components
│   └── dut.sv                # Device Under Test
├── testbench/
│   └── top_tb.sv             # Top-level testbench
├── README.md
└── .gitignore
```


## 🚀 How It Works

1. **Generator** → mailbox → **Driver**
2. **Driver** → DUT via Interface
3. **Monitors** → mailbox → **Scoreboard**
4. **Scoreboard** checks output correctness

## ✅ Features

- Randomization
- Mailbox communication
- Signal monitoring
- DUT scorechecking

## 🧪 Simulation

Run on:
- ModelSim / Questa
- Synopsys VCS
- Cadence Xcelium
- [EDA Playground](https://edaplayground.com/x/JAFn)

## 👨‍💻 Author

Mohd Akram Khan  
Design & Verification Trainee  
Jamia Millia Islamia

## 📄 License

MIT
