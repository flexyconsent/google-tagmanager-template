# FlexyConsent CMP — Google Tag Manager community template

The source of the **FlexyConsent CMP** tag template for the [Google Tag Manager Community Template
Gallery](https://tagmanager.google.com/gallery). It puts Google Consent Mode v2 under the visitor's
real choice, from inside Tag Manager, on the *Consent Initialization – All Pages* trigger — so every
other tag in the container is held behind it.

> **This directory is the master copy. It is not what the gallery reads.** The gallery requires the
> template to live in its own **public** GitHub repository, with `template.tpl`, `metadata.yaml` and
> `LICENSE` at the repository root: **`github.com/flexyconsent/google-tagmanager-template`**. Run
> `./publish.sh` to build it. See *Publishing* below.
>
> **Published 2026-09-24** (initial release `6070360`, submitted to the gallery the same day). An update
> is a new commit there plus its sha at the top of `versions` in `metadata.yaml`.

## What the tag does, in order

1. `gtagSet('ads_data_redaction', …)` and `gtagSet('url_passthrough', …)`.
2. `setDefaultConsentState(…)` — one call per row of the *Default consent state* table, or a single
   denied-except-`functionality_storage` baseline when the table is empty. Every call carries
   `wait_for_update`, which is the grace period the rest of the container observes.
3. Subscribes to `window.__fcapi` — FlexyConsent's publisher consent API — via `callInWindow`.
4. `updateConsentState(…)` on the visitor's decision, and again on **every later change**, including
   a mid-page withdrawal.
5. Optionally injects the FlexyConsent script, for sites whose only installed code is GTM.

### Why it does not use `gtag('consent', …)`

Google is explicit that a community template must not: gtag commands queue behind every other
pending message and can be processed after the next event has already begun. The native
`setDefaultConsentState` / `updateConsentState` APIs are ordered correctly against the container's
event loop. FlexyConsent's own page script *does* use the gtag command — that is the right call from
page source and the wrong one from inside a template.

### Where the answer comes from

`__fcapi` is defined at parse time by a stub, before the CMP bundle has loaded, and **a listener
registered against that stub is adopted by the real implementation rather than dropped** — so
subscribing from this tag is safe however early it runs. See `docs/publisher-consent-api.md`.

The visitor's choice is read from `window._fc_gcm`: the seven consent types, already computed by the
page from cookie categories OR-ed with IAB TCF purposes, most-permissive. **Reading the computed
answer rather than recomputing it is the point** — a second copy of the mapping inside the GTM
sandbox would be free to drift from the one merchants actually see. The template does carry a
category fallback for a page still serving a script from before `_fc_gcm` shipped, and
`validate-template.js` check 6 fails if that fallback stops matching `cmp_inpage.js`.

## Installing it (what a merchant does)

1. **Templates → Tag Templates → Search Gallery → FlexyConsent CMP → Add to workspace.**
2. **Tags → New → FlexyConsent CMP.**
3. Paste the script ID or the whole script URL from the FlexyConsent dashboard install snippet.
4. **Triggering → Consent Initialization – All Pages.** Not *All Pages* — the consent trigger is the
   one that runs before everything else.
5. Leave *Wait for update* at 500 unless tags fire before the banner on a first visit; raise it
   towards 2000 then.

If the FlexyConsent snippet is already in the page source — the better placement, because a script
in the `<head>` can block trackers from the first byte — untick *Load the FlexyConsent script from
this tag*. The tag then only wires consent to Google's tags.

## Checking it before publishing

```bash
node tools/gtm-template/validate-template.js
```

54 checks: section structure and order, every JSON block, that the sandboxed code parses, that every
consent type the code writes is granted write access (**one missing type aborts the entire tag,
script injection included** — it does not degrade, it disappears), that every global read is
permitted, that no default is sent without `wait_for_update` and no update is sent with it, and that
the fallback mapping still matches `cmp_inpage.js`.

The `___TESTS___` inside `template.tpl` are a different thing: **they only run inside the Tag Manager
template editor.** There is no offline runner for them. Open the template in GTM and press *Run
tests* before publishing a version — that is the only place they execute.

## Publishing

The gallery's requirements, read from
<https://developers.google.com/tag-platform/tag-manager/templates/gallery> on 2026-09-19:

- A **public** GitHub repository, **one template per repository**, everything on the **main** branch.
- `template.tpl`, `metadata.yaml` and `LICENSE` (that spelling, all caps, **Apache 2.0 only**) at the
  **repository root**. `README.md` is recommended.
- **GitHub Issues must be enabled**, with email notification — merchants report template bugs there.
- Submit at <https://tagmanager.google.com/gallery> → ⋮ → **Submit Template** → repository URL.
- Updates: add a new `sha` to the **top** of the `versions` list in `metadata.yaml`. The gallery
  picks it up "typically within 2 to 3 days".
- Removal: delete `LICENSE` or `metadata.yaml` and the gallery drops the template automatically.

Submission appears to be automatic on providing the repository URL — Google documents no approval
step. That is a statement about the *gallery*, not about CMP certification, which is a separate
assessment (see `docs/google-cmp-certification-intake.md`).

### The owner is the publisher name

The gallery addresses a template as `gallery/#/owners/<github-owner>/templates/<repo>` and shows the
**owner** as who published it — so the GitHub account name is brand-facing, more so than the repo
name. It is **`flexyconsent`** (decided 2026-09-20; `westcoasttech` on GitHub is an unrelated 2022
account). `brand.id` in `template.tpl` follows it as `github.com_<owner>` and must be changed with it.

### `./publish.sh`

Builds the four-file publish tree into `.publish/`, validates it, and makes the two commits the
gallery needs — because `metadata.yaml` must name the sha of a commit that *contains* the
`template.tpl` being served, which cannot be known until that commit exists. Name an earlier sha and
the gallery quietly serves an older template than the one in the repo.

It publishes nothing without `--push`, and asks before creating a public repository.

### Two things must be true before submitting

1. ~~`metadata.yaml` must point `documentation:` at a page that exists.~~ **Done 2026-09-20** —
   <https://flexyconsent.com/docs/google-tag-manager/> is live, along with `/docs/installation/`
   (which is also what Google's CMP certification assessment is pointed at) and
   `/docs/publisher-api/`. Source: `static-web-sites/sites/flexyconsent.com/data/docs/`.
2. **The `sha` must be a real commit** in the published repository. The placeholder in this copy is
   forty zeroes and the validator fails on it deliberately.
