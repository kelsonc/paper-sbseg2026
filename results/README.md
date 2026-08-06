# Results Directory

This directory is reserved for outputs generated during artifact reproduction.

When `run_experiments.sh` is used, executed notebooks are written to:

```text
results/executed_notebooks/
```

Source notebooks in `notebooks/` are not overwritten. The expected experimental behavior and the values reported in the paper are documented in [`../docs/REPRODUCIBILITY.md`](../docs/REPRODUCIBILITY.md).

Generated executed notebooks do not need to be committed to the repository; they serve as local execution evidence.
