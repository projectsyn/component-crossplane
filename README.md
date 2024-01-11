# Commodore Component: crossplane

This is a [Commodore][commodore] Component for crossplane.

This repository is part of Project Syn.
For documentation on Project Syn and this component, see [syn.tools](https://syn.tools).

## Documentation

The rendered documentation for this component is available on the [Commodore Components Hub](https://hub.syn.tools/crossplane).

Documentation for this component is written using [Asciidoc][asciidoc] and [Antora][antora].
It can be found in the [`docs`](docs) folder.
We use the [Divio documentation structure](https://documentation.divio.com/) to organize our documentation.

Run the `make docs-serve` command in the root of the project, and then browse to http://localhost:2020 to see a preview of the current state of the documentation.

After writing the documentation, please use the `make docs-vale` command and correct any warnings raised by the tool.

## Local installation for testing purposes

`make install` allows you to install the operator in a local (kind) cluster.

The target installs the component Crossplane in a local cluster. This component uses [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator#quickstart).

Note: the namespace in the ClusterRoleBinding needs to be updated as we're deploying in a namespace other than the default namespace, that's why we have `kind/prometheus-operator-cluster-role-binding.yaml`

## Contributing and license

This library is licensed under [BSD-3-Clause](LICENSE).
For information about how to contribute, see [CONTRIBUTING](CONTRIBUTING.md).

[commodore]: https://syn.tools/commodore/
[asciidoc]: https://asciidoctor.org/
[antora]: https://antora.org/
