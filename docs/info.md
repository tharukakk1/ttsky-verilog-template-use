<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This design implements a basic **8-bit Full Adder**. It utilizes the `ui_in` and `uio_in` ports as two 8-bit operands. The circuit calculates the arithmetic sum of these two inputs, outputting the lower 8 bits of the result to `uo_out`. The final carry-out bit (the 9th bit) is mapped to the first bit of the `uio_out` bus to indicate an overflow condition.

## How to test

The functionality was verified using a **self-checking Verilog testbench**.
- **Coverage**: The testbench iterates through a series of input combinations to ensure the adder handles standard additions and zero-value inputs.
- **Verification**: It uses automated comparison logic to verify the hardware output against an expected reference value, reporting a clear success or failure message upon completion.
- **Edge Cases**: The testbench specifically verifies the **Carry Out** bit logic by testing additions that exceed the 8-bit limit (e.g. 255+1), ensuring the 9th bit is correctly asserted.

## External hardware

No external hardware is required beyond the standard TinyTapeout input switches and output LEDs. `ui_in` and `uio_in` serve as the 8-bit inputs, while `uo_out` displays the 8-bit sum.

## Use of GenAI
I used GenAI tools, specifically Google Gemini, to assist in writing the Verilog testbench, by having it write a fillable template based on testbench I wrote in CSE225 in the past fall quarter. I also used it to easily format my words into this Markdown file here.
