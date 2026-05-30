# GitHub Deploy Setup

This project now includes a GitHub Actions workflow at `.github/workflows/deploy.yml`.

It deploys when code is pushed to the `main` branch.

## GitHub secrets

Add these repository secrets in GitHub:

- `DEPLOY_HOST`
- `DEPLOY_PORT`
- `DEPLOY_USER`
- `DEPLOY_SSH_KEY`
- `DEPLOY_PATH`

Example:

- `DEPLOY_HOST` = `your-server-ip-or-domain`
- `DEPLOY_PORT` = `22`
- `DEPLOY_USER` = `forge`
- `DEPLOY_PATH` = `/var/www/axion_ds`
- `DEPLOY_SSH_KEY` = private SSH key used by GitHub Actions to connect to your server

## Optional repository variable

Add this repository variable if you want a different branch:

- `DEPLOY_BRANCH`

Default is `main`.

## Server requirements

The server must already:

- have this repository cloned at `DEPLOY_PATH`
- allow SSH login for `DEPLOY_USER` using the private key paired with `DEPLOY_SSH_KEY`
- be able to run `git pull origin main`
- have access to pull from GitHub from inside the server project directory
- have PHP, Composer, and project dependencies installed

## Current deploy commands

The workflow currently runs:

```bash
git pull origin main
composer install --no-interaction --prefer-dist --optimize-autoloader
php artisan migrate --force
php artisan optimize:clear
```

If your server also needs frontend build steps like `npm install` and `npm run build`, we can add that next.
