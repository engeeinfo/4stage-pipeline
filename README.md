# Four-Stage Pipeline

A small Verilog RTL example of a four-stage datapath pipeline.

## Files

- `pipe.v` - pipeline implementation
- `pipe_tb.v` - simulation testbench

## Simulate

```bash
iverilog -o pipeline_tb pipe.v pipe_tb.v
vvp pipeline_tb
```