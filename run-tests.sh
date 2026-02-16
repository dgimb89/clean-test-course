#!/bin/sh
set -e

echo "=== Installing Python 3 ==="
apt-get update -qq && apt-get install -y -qq python3 python3-pip > /dev/null 2>&1

echo "=== Installing backend dependencies ==="
pip3 install --break-system-packages -r /backend/hangry_api/requirements.txt pytest django-mock-queries --quiet

echo "=== Running backend tests ==="
cd /backend/hangry_api
python3 -m pytest tests/ -v

echo "=== Running frontend tests ==="
cd /app
npm install
npx react-scripts test --watchAll=false

echo "=== All tests passed ==="
