# Synchronous FIFO in Verilog

## 📌 Project Overview

This project implements a **Synchronous FIFO (First-In First-Out)** memory using Verilog HDL.

A FIFO stores data in the order it is written. The first data written into the FIFO is the first data read from it.

This design uses a **single clock** for both read and write operations.

## 🎯 Features

* Synchronous read and write operations
* Single clock input
* Parameterized data width and FIFO depth
* `full` flag
* `empty` flag
* Reset functionality
* Read and write pointers
* FIFO occupancy counter

## 🛠️ Specifications

| Parameter  |       Value |
| ---------- | ----------: |
| Data Width |      8 bits |
| FIFO Depth |           8 |
| Clock      |      Single |
| Reset      | Synchronous |
| Language   | Verilog HDL |

## 🔌 Inputs

* `clk` – System clock
* `rst` – Synchronous reset
* `wr_en` – Write enable
* `rd_en` – Read enable
* `data_in` – 8-bit input data

## 🔌 Outputs

* `data_out` – 8-bit output data
* `full` – Indicates FIFO is full
* `empty` – Indicates FIFO is empty

## ⚙️ Working

1. When `rst` is high, the FIFO is cleared.
2. When `wr_en` is high and the FIFO is not full, input data is stored.
3. When `rd_en` is high and the FIFO is not empty, data is read.
4. The write pointer moves after a successful write.
5. The read pointer moves after a successful read.
6. The counter keeps track of the number of stored elements.
7. `full` becomes high when all FIFO locations are occupied.
8. `empty` becomes high when there is no data in the FIFO.

## 🧪 Simulation

The testbench performs:

* Reset
* Multiple write operations
* Multiple read operations
* Full FIFO test
* Empty FIFO test
* Simultaneous read/write operation

## ▶️ How to Run

Using **Icarus Verilog**:

```bash
iverilog -o fifo_sim synchronous_fifo.v synchronous_fifo_tb.v
vvp fifo_sim
```

Using **GTKWave**:

```bash
gtkwave fifo.vcd
```

## 📚 Applications

Synchronous FIFOs are commonly used in:

* Digital systems
* Data buffering
* Processor interfaces
* Communication systems
* FPGA designs
* UART/SPI interfaces
* Digital signal processing systems

## 👩‍💻 Author

**Verilog HDL Digital Design Project**

## 📄 License

This project is created for educational and academic purposes.
