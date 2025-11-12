#!/bin/bash

# === Configuration ===
CHANGELOG="CHANGELOG.md"

# Get new version number from argument
VERSION="$1"

# Get today's date
TODAY=$(date +%F)

# Check version argument
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <new_version_tag> (e.g. v0.3.0)"
    exit 1
fi

# Backup file
cp "$CHANGELOG" "${CHANGELOG}.bak"

# Extract lines under [Unreleased] section
UNRELEASED_CONTENT=$(awk '/^## \[Unreleased\]/ {flag=1; next} /^## \[.*\]/ {flag=0} flag' "$CHANGELOG")

if [ -z "$UNRELEASED_CONTENT" ]; then
    echo "No [Unreleased] content found to release."
    exit 1
fi

# Insert new version section below [Unreleased]
awk -v ver="$VERSION" -v date="$TODAY" -v content="$UNRELEASED_CONTENT" '
    BEGIN { print_ok = 1 }
    {
        print $0
        if ($0 ~ /^## \[Unreleased\]/ && print_ok) {
            print "\n## [" ver "] - " date "\n" content
            print_ok = 0
        }
    }
' "$CHANGELOG" > "${CHANGELOG}.tmp" && mv "${CHANGELOG}.tmp" "$CHANGELOG"

echo "✅ Released $VERSION on $TODAY"

# Auto commit and push if in GitHub Actions
if [ -n "$GITHUB_ACTIONS" ]; then
  git config user.name "github-actions[bot]"
  git config user.email "github-actions[bot]@users.noreply.github.com"
  git add CHANGELOG.md
  git commit -m "chore: update changelog for $VERSION"
  git push origin HEAD
fi

