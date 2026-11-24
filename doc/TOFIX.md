# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `rsconstruct.toml:1-43` - there is no `[processor.tera]` / `[analyzer.tera]`, so `tera.templates/.github/dependabot.yml.tera` is never rendered and `.github/dependabot.yml` is a hand-kept copy (it already differs from the template's output, e.g. no blank line between entries). Add the tera analyzer and processor (`dep_auto = ["config/project.lua"]`, `src_dirs = ["tera.templates"]`) and let it generate the file.
- `src/hello.d:1-5` - the repo "Demos for the D programming language" contains a single hello-world; the D source is checked by no linter or formatter. Add a D lint step (e.g. `dscanner` via a processor or `ldc2 -w -de` warnings-as-errors in `scripts/ldc2_build.py:18-19`) and more than one demo, or say in the README that it is a stub.

## Low

- `rsconstruct.toml:10` and `rsconstruct.toml:14` - `ruff` and `mypy` scan `src`, which contains only `.d` files; list just `["scripts"]`.
- `pyproject.toml:10` - `pytest` is in the dev group but the repo has no tests and no pytest processor; drop it.
- `src/hello.d:4` - the body is indented with a tab followed by four spaces; use one consistent indent.
- `README.md:2` vs `config/project.lua:3` - two different descriptions ("Demos for the D programming language" vs "Demos for the d language"); align them.
