# Publishing IU Alumni to Google Play

One-time setup for the `Release Android (Google Play)` workflow.

The app is already Android-ready: package `com.innopolis.alumni`, label "IU Alumni",
and `android/app/build.gradle` reads its signing config from environment
variables. What was missing was an **App Bundle** build (Play does not accept the
`.apk` that `build-apk.sh` produces for RuStore) and a way to upload it.

Steps marked **[you]** must be done by a human — they involve account creation,
payment, or accepting legal agreements.

---

## 1. Google Play developer account **[you]**

<https://play.google.com/console/signup> — one-time **$25** fee, and you must
accept the Developer Distribution Agreement.

For a university-owned app, register an **organisation** account rather than a
personal one, so ownership survives people leaving. Organisation accounts need
a D-U-N-S number and take longer to verify — start this first, it is the long
pole.

## 2. Create the app **[you]**

Play Console → **Create app**:

| field | value |
|---|---|
| App name | IU Alumni |
| Default language | English (or Russian, if that is the primary audience) |
| App or game | App |
| Free or paid | Free |

Then **Dashboard → Set up your app** and complete every item. Play will not let
you roll out to *any* track, including internal testing, until these are done:

- Privacy policy URL — required because the app handles accounts and email
- Data safety — declare what is collected. Be accurate: the app sends email,
  name, graduation year, location, and Telegram alias to your own backend
- Content rating questionnaire
- Target audience and content
- Ads declaration — the app has no ads; the `AD_ID` permission is commented out
  in `AndroidManifest.xml`, which matches "no advertising ID"
- App category and contact details

## 3. Generate the upload keystore **[you]**

Do this yourself so the password never passes through anyone else. From the repo:

```bash
./build-apk.sh --generate-keystore
```

That writes `~/iu-alumni-release.jks`. Or directly:

```bash
keytool -genkeypair -v -keystore ~/iu-alumni-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

> **Back this file up somewhere durable.** With Play App Signing, Google holds
> the *app signing* key and this is your *upload* key — a lost upload key can be
> reset by Google support, but it is a slow process. Losing it is recoverable;
> losing it *and* having no account access is not.

## 4. Google Play service account **[you]**

This is what lets CI upload without a human.

1. Play Console → **Setup → API access** → link (or create) a Google Cloud project
2. In Google Cloud → **IAM & Admin → Service Accounts** → create one, e.g.
   `play-publisher`
3. On that service account → **Keys → Add key → JSON** → download it
4. Back in Play Console → **Users and permissions → Invite new user** → paste the
   service-account email, and grant **app-level** access to IU Alumni with:
   - *Release to testing tracks*
   - *Release to production* (only if you want CI to publish live)

Least privilege: grant only the testing-track permission until you trust the
pipeline end to end.

## 5. Add repository secrets **[you]**

`Settings → Secrets and variables → Actions` in `iu-alumni-mobile`. The workflow
uses the **production** environment, so add them there (or at repo level).

| secret | value |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | `base64 -i ~/iu-alumni-release.jks` (macOS) / `base64 -w0` (Linux) |
| `ANDROID_KEYSTORE_PASSWORD` | keystore password from step 3 |
| `ANDROID_KEY_ALIAS` | `upload` |
| `ANDROID_KEY_PASSWORD` | key password (often the same) |
| `PLAY_SERVICE_ACCOUNT_JSON` | full contents of the JSON from step 4 |

`API_BASE_URL`, `APP_METRICA_KEY` and `IU_ALUMNI_WEB_SALT` already exist.

## 6. First upload

Play sometimes rejects the very first API upload for an app that has never had a
bundle. If step 7 fails with *"Package not found"* or similar, upload the
artifact once by hand — run the workflow, download the `app-release-*.aab`
artifact it attaches, and drop it into **Internal testing → Create new release**.
Subsequent runs go through the API fine.

## 7. Run the pipeline

Actions → **Release Android (Google Play)** → Run workflow:

- `track`: `internal` to start
- `release_status`: `draft` — uploads without rolling out, so you can inspect it
  in the console first

Once you trust it, use `completed` to roll out, and `beta` / `production` as the
app matures. Pushing a `v*` tag also triggers a build.

### Versioning

`versionCode` is `100 + github.run_number`, so it always increases — Play rejects
a bundle whose code is not higher than the last one. `versionName` comes from a
`v*` tag if present, otherwise `pubspec.yaml`, and can be overridden per run.

The offset exists so codes stay above anything published before this pipeline. If
you have already shipped a build with a code above 100, raise
`VERSION_CODE_OFFSET` in the workflow.

---

## What is not automated

- **Store listing** (description, screenshots, feature graphic) — the upload runs
  with `--skip_upload_metadata` and friends, so CI never overwrites what you
  write in the console. Add a `fastlane/metadata` tree later if you want it in git.
- **Staged rollouts** — add `--rollout 0.1` to the `fastlane supply` call.
- **iOS / App Store** — separate pipeline, needs an Apple Developer account
  ($99/year) and a macOS runner.
