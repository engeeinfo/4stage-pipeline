# Architecture

`pipe` accepts source register indexes, a destination register index,
operation selector, and address metadata. The pipeline captures inputs on
alternating clock phases and exposes the arithmetic result on `z`.

The testbench initializes `regbank` directly because this repository is a
pipeline experiment rather than a complete processor bus. A future integration
should replace hierarchical initialization with a defined register-file
interface.
