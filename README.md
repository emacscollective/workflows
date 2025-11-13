## GitHub Actions workflows for use in packages I maintain

These actions are tailored to how things are done in these packages.
Using them unmodified for your own packages likely won't work.

## Used third-party actions

- [actions/checkout@v4](https://github.com/actions/checkout)
- [aws-actions/configure-aws-credentials@v4](https://github.com/aws-actions/configure-aws-credentials)
- [purcell/setup-emacs@master](https://github.com/purcell/setup-emacs)

## Related resources

- [emacscollective/org-macros] contains macros used in my manuals.
- [emacsmirror/.savannah] actions to mirror GNU Emacs and [Non]GNU Elpa.
- [magit/actions] the deprecated predecessor of these workflows, which uses
  actions instead.  Don't do that—you would have to add more boilerplate to
  your repositories, and what's worse, you would much more frequently end up
  having to update each copy.

## Compile

Used by nearly all of my packages.

Usage:

```yaml
name: Compile
on: [push, pull_request]
jobs:
  compile:
    name: Compile
    uses: emacscollective/workflows/.github/workflows/compile.yml@main
```

## Run tests

Used by [`emacsql`] and [`magit`].

Usage:

```yaml
name: Test
on: [push, pull_request]
jobs:
  test:
    name: Test
    uses: emacscollective/workflows/.github/workflows/test.yml@main
```

## Generate and distribute manuals

Used by [`borg`], [`epkg`], [`forge`], [`ghub`], [`magit`], [`magit-section`],
[`transient`] and [`with-editor`].  Results can be found [here](manuals-magit)
and [here](manuals-mirror).

Usage:

```yaml
name: Manual
on:
  push:
    branches: main
    tags: "v[0-9]+.[0-9]+.[0-9]+"
jobs:
  manual:
    name: Manual
    uses: emacscollective/workflows/.github/workflows/manual.yml@main
    secrets:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Generate and distribute webpage

> [!NOTE]
> [emacsair.me], [emacsmirror.net] and [magit.vc] are still published
> using actions from [magit/actions].

## Generate and distribute page from readme

Used by [`no-littering`].

Usage:

```yaml
name: Readme
on:
  push:
    branches: main
jobs:
  manual:
    name: Readme
    uses: emacscollective/workflows/.github/workflows/readme.yml@main
    secrets:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Generate and distribute statistics

Used by [`borg`], [`emacsql`], [`epkg`], [`forge`], [`ghub`], [`magit`],
[`transient`] and [`with-editor`].  Results can be found [here][stats-magit]
and [here][stats-mirror].

Usage:

```yaml
name: Statistics
on:
  push:
    branches: main
  schedule:
    - cron: '3 13 * * 1'
jobs:
  stats:
    name: Statistics
    uses: emacscollective/workflows/.github/workflows/stats.yml@main
    secrets:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

[`borg`]:          https://github.com/emacscollective/borg
[`emacsql`]:       https://github.com/magit/emacsql
[`epkg`]:          https://github.com/emacscollective/epkg
[`forge`]:         https://github.com/magit/forge
[`ghub`]:          https://github.com/magit/ghub
[`magit`]:         https://github.com/magit/magit
[`magit-section`]: https://github.com/magit/magit
[`no-littering`]:  https://github.com/emacscollective/no-littering
[`transient`]:     https://github.com/magit/transient
[`with-editor`]:   https://github.com/magit/with-editor

[emacsair.me]:     https://emacsair.me
[emacsmirror.net]: https://emacsmirror.net
[magit.vc]:        https://magit.vc

[manuals-magit]:   https://magit.vc/manual/
[manuals-mirror]:  https://emacsmirror.net/manual/
[stats-magit]:     https://magit.vc/stats/
[stats-mirror]:    https://emacsmirror.net/stats/

[emacscollective/org-macros]: https://github.com/emacscollective/org-macros
[emacscollective/workflow-experiments]: https://github.com/emacscollective/workflow-experiments
[emacsmirror/.savannah]: https://github.com/emacsmirror/.savannah.git
[magit/actions]: https://github.com/magit/actions
