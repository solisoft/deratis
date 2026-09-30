# Dératis

Site of [Dératis](https://deratis.fr), pest control in the Gard, Lozère and
Ardèche: rodent control, insect control, wasp and hornet nests. Built with
[Soli](https://github.com/solisoft/soli_lang).

## Develop

```bash
soli db:migrate up          # SoliDB on localhost:6745, see .env
soli serve . --dev          # http://localhost:5011, Tailwind recompiles on save
bin/verifier                # format, lint, tests at 90 % coverage — what CI runs
```

Content that several pages share (specimens, intervention steps, articles,
communes) lives in `app/services/site.sl`; the prose lives in the views.
Service and article URLs keep the paths of the previous site.

## Deploy

`.github/workflows/ci.yml` checks every push and pull request, and deploys
`main` to **deratis.solisoft.net** once the check is green: rsync to the
server, `soli db:migrate up`, then a blue-green switch by `soli-proxy`.

Until the `production` environment holds its secrets, the deploy job reports
what is missing and stops without failing.

| Kind | Name | Value |
|------|------|-------|
| secret | `DEPLOY_HOST` | server address |
| secret | `SSH_DEPLOY_KEY` | private key allowed into `rocky@DEPLOY_HOST` |
| secret | `SSH_KNOWN_HOSTS` | `ssh-keyscan DEPLOY_HOST` output |
| variable | `DEPLOY_USER`, `DEPLOY_SITES_DIR`, `DEPLOY_SITE_DIR`, `DEPLOY_DOMAIN`, `DEPLOY_APP` | optional; defaults in the workflow |

The site folder (`/home/rocky/sites/deratis.solisoft.net/`) must exist on the
server with its own `.env` and `app.infos` before the first deploy; the
workflow creates neither.
