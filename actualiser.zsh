#!/bin/zsh
set -eu

plugin_dir=${0:A:h}
skills_dir="$plugin_dir/skills"
cd -- "$plugin_dir"

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
    print -ru2 -- "Ce dossier doit être dans un dépôt Git pour publier les skills."
    exit 1
fi

if ! branch="$(git symbolic-ref --quiet --short HEAD)"; then
    print -ru2 -- "Sélectionne la branche Git à publier avant de lancer le script."
    exit 1
fi

push_args=()
if ! git config --get "branch.$branch.merge" >/dev/null; then
    if ! git remote get-url origin >/dev/null 2>&1; then
        print -ru2 -- "Configure une branche distante ou le remote Git origin."
        exit 1
    fi
    push_args=(--set-upstream origin "$branch")
fi

apple_export="$(xcrun agent plugin path --plugin-format codex)"
skill_manifests=("$apple_export"/skills/*/SKILL.md(N))
if (( ${#skill_manifests} == 0 )); then
    print -ru2 -- "L’export ne contient aucun skill Xcode : $apple_export"
    exit 1
fi

staging_dir="$(mktemp -d "${plugin_dir:h}/.actualisation-xcode.XXXXXX")"
cleanup() {
    if [[ -d "$staging_dir/previous" && ! -e "$skills_dir" ]]; then
        mv "$staging_dir/previous" "$skills_dir" || return
    fi
    rm -r "$staging_dir"
}
trap cleanup EXIT

ditto "$apple_export/skills" "$staging_dir/skills"
if [[ -d "$skills_dir" ]]; then
    mv "$skills_dir" "$staging_dir/previous"
fi
mv "$staging_dir/skills" "$skills_dir"

print -r -- "Skills copiés depuis l’export Apple : ${#skill_manifests} ($apple_export)"
git add -A -- skills/
if git diff --cached --quiet -- skills/; then
    print -r -- "Les skills correspondent déjà au dernier commit."
else
    xcode_build=${apple_export:h:t}
    diff_summary="$(git diff --cached --shortstat -- skills/)"
    affected_skills="$(git diff --cached --name-only --no-renames --relative -- skills/ |
        cut -d / -f 2 | sort -u)"

    git commit --only \
        -m "chore(xcode): synchroniser les skills Apple ($xcode_build)" \
        -m "Aligne les instructions et les références sur l’export officiel du Xcode actif." \
        -m "Build Xcode $xcode_build · ${#skill_manifests} skills exportés
${diff_summary# }" \
        -m "Dossiers concernés
$affected_skills" \
        -- skills/
fi

git push "${push_args[@]}"
