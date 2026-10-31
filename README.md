# Four-Stage Pipeline

Verilog demonstration of a four-stage arithmetic pipeline supporting add and
subtract operations.

## Requirements

- Icarus Verilog 11 or newer
- `make`

Run the self-checking simulation:

```sh
make test
```

The testbench initializes the register bank and verifies the pipeline latency
and arithmetic results for several add/subtract instructions.

## Structure

- `pipe.v` contains the pipeline and register bank.
- `pipe_tb.v` contains the arithmetic regression.
- `docs/ARCHITECTURE.md` and `docs/MODERNIZATION.md` document the design and
  baseline.
