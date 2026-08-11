# SPI Master using Verilog

## 📌 Overview

This project implements an **SPI (Serial Peripheral Interface) Master** using Verilog HDL.

SPI is a synchronous serial communication protocol commonly used for communication between a microcontroller/FPGA and peripheral devices such as sensors, memory devices, ADCs, and displays.

## ⚙️ Features

* 8-bit data transmission
* MSB-first transmission
* Serial Clock (SCLK) generation
* Master Out Slave In (MOSI) output
* Chip Select (CS) control
* Busy and Done status signals
* Active-high reset

## 🔌 SPI Signals

| Signal    | Description                           |
| --------- | ------------------------------------- |
| `clk`     | System clock                          |
| `reset`   | Active-high reset                     |
| `start`   | Starts SPI transmission               |
| `data_in` | 8-bit parallel data to transmit       |
| `sclk`    | SPI serial clock                      |
| `mosi`    | Master Out Slave In                   |
| `cs`      | Chip Select                           |
| `busy`    | Indicates transmission is in progress |
| `done`    | Indicates transmission is complete    |

## 🧠 Working Principle

The SPI Master accepts an 8-bit parallel input through `data_in`.

When `start` is asserted:

1. `CS` goes LOW.
2. The input data is loaded into a shift register.
3. The most significant bit is placed on `MOSI`.
4. `SCLK` toggles to transmit the data serially.
5. The data is shifted one bit at a time.
6. After all 8 bits are transmitted, `CS` returns HIGH.
7. `done` is asserted to indicate the completion of transmission.

The design uses **MSB-first** data transmission.

## 📂 Project Structure

```text
SPI-Master/
├── README.md
├── spi_master.v
└── spi_master_tb.v
```

## 🧪 Testbench

The testbench transmits two 8-bit data values:

```text
Data 1 = 10101010
Data 2 = 11001100
```

### Expected MOSI Sequence

For the first transmission:

```text
MOSI = 1 0 1 0 1 0 1 0
```

For the second transmission:

```text
MOSI = 1 1 0 0 1 1 0 0
```

## 📊 Expected Output

```text
Data: 10101010

CS   : LOW
SCLK : Clock pulses
MOSI : 1 0 1 0 1 0 1 0
BUSY : HIGH
DONE : LOW

After 8 bits:

CS   : HIGH
BUSY : LOW
DONE : HIGH
```

Then the second data byte is transmitted:

```text
Data: 11001100

MOSI : 1 1 0 0 1 1 0 0
```

## 📈 Expected Waveform

```text
CS    ────────┐____________________________┌────
              │                            │
              └────────────────────────────┘

SCLK          ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
              └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘

MOSI          1   0   1   0   1   0   1   0
```

## 🛠️ Tools Used

* Verilog HDL
* Xilinx Vivado
* ModelSim
* Icarus Verilog
* GTKWave

## 🎯 Applications

SPI communication is widely used in:

* Sensors
* EEPROM and Flash memory
* ADC/DAC devices
* LCD/OLED displays
* SD cards
* FPGA-to-peripheral communication
* Embedded systems

## 📚 Conclusion

The SPI Master demonstrates how parallel data can be converted into a serial data stream using Verilog HDL. The design generates the SPI clock, controls chip select, and transmits data through the MOSI line using MSB-first transmission.
