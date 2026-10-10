___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "FlexyConsent CMP",
  "categories": [
    "TAG_MANAGEMENT",
    "UTILITY"
  ],
  "brand": {
    "id": "github.com_flexyconsent",
    "displayName": "FlexyConsent"
  },
  "description": "Load the FlexyConsent consent management platform and set Google Consent Mode v2 defaults before any other tag on the page fires, then update them from the visitor's own choice. IAB TCF v2.4 CMP ID 317, IAB GPP v1.1 and Google Additional Consent v2.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "CHECKBOX",
    "name": "loadScript",
    "checkboxText": "Load the FlexyConsent script from this tag",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Leave this ticked if Google Tag Manager is the only thing installed on your site. Untick it if the FlexyConsent snippet is already in your page source — that is the better placement, because a script in the head can block trackers from the first byte, and this tag will then only wire your consent to Google's tags."
  },
  {
    "type": "TEXT",
    "name": "scriptId",
    "displayName": "Consent script ID or URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "loadScript",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "help": "From the install snippet on your FlexyConsent dashboard. Paste either the whole script URL (https://flexyconsent.com/d/6/1/9/6194....js) or just the 40-character ID inside it. A GTM variable can be used here."
  },
  {
    "type": "GROUP",
    "name": "consentModeGroup",
    "displayName": "Google Consent Mode",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "PARAM_TABLE",
        "name": "defaultSettings",
        "displayName": "Default consent state",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "region",
              "displayName": "Region",
              "simpleValueType": true,
              "help": "Comma-separated uppercase region codes, e.g. DE, FR, US-CA. Leave blank to apply to every region."
            },
            "isUnique": true
          },
          {
            "param": {
              "type": "SELECT",
              "name": "ad_storage",
              "displayName": "Ad storage",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "denied"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "ad_user_data",
              "displayName": "Ad user data",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "denied"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "ad_personalization",
              "displayName": "Ad personalization",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "denied"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "analytics_storage",
              "displayName": "Analytics storage",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "denied"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "functionality_storage",
              "displayName": "Functionality storage",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "granted"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "personalization_storage",
              "displayName": "Personalization storage",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "denied"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "security_storage",
              "displayName": "Security storage",
              "selectItems": [
                {"value": "denied", "displayValue": "Denied"},
                {"value": "granted", "displayValue": "Granted"}
              ],
              "simpleValueType": true,
              "defaultValue": "denied"
            },
            "isUnique": false
          }
        ],
        "newRowButtonText": "Add a region",
        "help": "What Google's tags may do BEFORE the visitor has answered the banner. Leave the table empty to deny everything except functionality storage, which is the safe default and the one FlexyConsent itself uses."
      },
      {
        "type": "TEXT",
        "name": "waitForUpdate",
        "displayName": "Wait for update (milliseconds)",
        "simpleValueType": true,
        "defaultValue": "500",
        "valueValidators": [
          {
            "type": "POSITIVE_NUMBER"
          }
        ],
        "help": "How long Google's tags hold their events waiting for this visitor's answer before falling back to the defaults above. 500 is enough for a returning visitor, whose stored choice is replayed as soon as the FlexyConsent script parses. Raise it towards 2000 if your tags fire before the banner on a first visit."
      },
      {
        "type": "CHECKBOX",
        "name": "adsDataRedaction",
        "checkboxText": "Redact ads data when ad storage is denied",
        "simpleValueType": true,
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "urlPassthrough",
        "checkboxText": "Pass ad click and session information in URLs when storage is denied",
        "simpleValueType": true,
        "defaultValue": false
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// FlexyConsent CMP — Google Tag Manager community template.
//
// WHAT THIS TAG IS FOR. It puts Google Consent Mode v2 under the visitor's actual choice, from
// inside Tag Manager, on the Consent Initialization trigger — so every other tag in the container
// is held behind it. Optionally it also loads the FlexyConsent script itself, for sites whose only
// installed code is the Tag Manager container.
//
// WHY IT DOES NOT USE `gtag('consent', ...)`. Google is explicit that a template must not: gtag
// commands are queued behind every other pending message and can be processed after the next event
// has already begun. The native setDefaultConsentState / updateConsentState APIs are ordered
// correctly against the container's own event loop. FlexyConsent's page script does use the gtag
// command — that is the right call from page source and the wrong one from here.
//
// WHERE THE ANSWER COMES FROM. `window.__fcapi` is FlexyConsent's publisher consent API. It is
// defined at parse time by a stub, before the CMP bundle has loaded, and a listener registered
// against that stub is adopted by the real implementation rather than dropped — so subscribing
// from here is safe however early this tag runs. The stub is documented at
// https://flexyconsent.com/docs/publisher-api/ and its shape is fixed at apiVersion 1.0.
//
// The visitor's choice reaches us as `window._fc_gcm`: the seven consent types, already
// computed by the page from cookie categories OR-ed with IAB TCF purposes, most-permissive. Reading
// the computed answer rather than recomputing it is deliberate — a second copy of the mapping
// inside this sandbox would be free to drift from the one merchants actually see. The category
// fallback below exists only for a page still serving a script from before `_fc_gcm` shipped, and
// validate-template.js check 6 fails if it stops matching cmp_inpage.js.

const log = require('logToConsole');
const copyFromWindow = require('copyFromWindow');
const callInWindow = require('callInWindow');
const injectScript = require('injectScript');
const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const gtagSet = require('gtagSet');
const makeNumber = require('makeNumber');
const templateStorage = require('templateStorage');

// Every type this tag is allowed to write. setDefaultConsentState and updateConsentState need write
// access to EVERY key in the object they are handed, so one type missing from the access_consent
// permission block fails the whole call and takes the rest of the tag down with it — including the
// script injection. Keep this list and the permission block in step; validate-template.js check 4
// is what makes sure nobody has to remember.
const CONSENT_TYPES = [
  'ad_storage',
  'ad_user_data',
  'ad_personalization',
  'analytics_storage',
  'functionality_storage',
  'personalization_storage',
  'security_storage'
];

// FlexyConsent cookie category ID -> the consent types that category grants when the visitor
// accepts it. Mirrors SITE_DATA_TO_GCM in cmp_inpage.js. Category 1 (Essential) is absent because
// functionality_storage is granted unconditionally, exactly as the page does it.
const CATEGORY_TO_TYPES = {
  '2': ['analytics_storage'],
  '3': ['ad_storage', 'ad_user_data'],
  '4': ['personalization_storage'],
  '5': ['security_storage']
};
// ad_personalization is the one signal with an AND dependency: Marketing (3) AND Personalization
// (4) must both be accepted. Mirrors SITE_DATA_AND_PAIRS.
const AND_PAIRS = [{ signal: 'ad_personalization', require: ['3', '4'] }];

const isType = (key) => CONSENT_TYPES.indexOf(key) !== -1;
const isValue = (value) => value === 'granted' || value === 'denied';

// A list, without Array.isArray, which the sandbox does not provide. A string is excluded by the
// typeof even though it has a length.
const isList = (value) => !!value && typeof value === 'object' && typeof value.length === 'number';

const splitRegions = (raw) => {
  const out = [];
  if (typeof raw !== 'string') return out;
  const parts = raw.split(',');
  for (let i = 0; i < parts.length; i += 1) {
    const code = parts[i].trim().toUpperCase();
    // Google documents consent regions as uppercase ISO codes. A lowercase 'fr' typed into the cell
    // would otherwise reach setDefaultConsentState as a region that matches nobody, silently.
    if (code !== '') out.push(code);
  }
  return out;
};

// ---------------------------------------------------------------------------
// 1. Options that do not depend on the visitor, and must precede every tag.
// ---------------------------------------------------------------------------

gtagSet('ads_data_redaction', data.adsDataRedaction === true);
gtagSet('url_passthrough', data.urlPassthrough === true);

// ---------------------------------------------------------------------------
// 2. Defaults.
// ---------------------------------------------------------------------------

// The empty string is checked separately because makeNumber('') is 0, which would turn the grace
// period off rather than fall back to it; the self-inequality is the NaN test, the sandbox having
// no isNaN. A field holding only spaces is caught by the same trim.
const waitRaw = (typeof data.waitForUpdate === 'string') ? data.waitForUpdate.trim() : data.waitForUpdate;
const waitNum = makeNumber(waitRaw);
const waitUnset = (waitRaw === undefined || waitRaw === null || waitRaw === '');
const waitUsable = (waitNum === waitNum && waitNum >= 0);
if (!waitUnset && !waitUsable) {
  log('FlexyConsent CMP: "Wait for update" is not a non-negative number; using 500 ms.');
}
const waitForUpdate = (waitUnset || !waitUsable) ? 500 : waitNum;

// GTM sends nothing at all for an empty PARAM_TABLE, so a tag saved with no rows arrives here with
// data.defaultSettings undefined. Iterating that would throw before the script is injected, and the
// visitor would get no CMP at all — the failure would not look like a missing consent default.
const defaultRows = isList(data.defaultSettings) ? data.defaultSettings : [];

const applyDefaultRow = (row) => {
  const command = {};
  for (const key in row) {
    if (key === 'region') {
      const regions = splitRegions(row[key]);
      if (regions.length > 0) command.region = regions;
    } else if (isType(key) && isValue(row[key])) {
      command[key] = row[key];
    }
    // Anything else is dropped rather than forwarded. A key that is neither 'region' nor one of the
    // seven types would abort setDefaultConsentState for want of a permission, and with it the
    // whole tag. No such key exists today; this is what keeps adding a column from taking the CMP
    // down with it.
  }
  command.wait_for_update = waitForUpdate;
  setDefaultConsentState(command);
};

if (defaultRows.length === 0) {
  // The safe baseline, and the same one cmp_inpage.js uses: everything denied except the
  // functionality storage a site needs to work at all.
  setDefaultConsentState({
    ad_storage: 'denied',
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    analytics_storage: 'denied',
    functionality_storage: 'granted',
    personalization_storage: 'denied',
    security_storage: 'denied',
    wait_for_update: waitForUpdate
  });
} else {
  for (let i = 0; i < defaultRows.length; i += 1) applyDefaultRow(defaultRows[i]);
}

// ---------------------------------------------------------------------------
// 3. The visitor's own choice.
// ---------------------------------------------------------------------------

// What the page computed, if this script is new enough to publish it.
const readPublishedSignals = () => {
  // The whole global, not a dotted path: copyFromWindow takes a single key. `_fc_gcm` is published
  // flat for exactly this reason — seven string values, nothing nested to survive the copy.
  const published = copyFromWindow('_fc_gcm');
  if (!published || typeof published !== 'object') return undefined;
  const out = {};
  let seen = false;
  for (const key in published) {
    if (isType(key) && isValue(published[key])) {
      out[key] = published[key];
      seen = true;
    }
  }
  return seen ? out : undefined;
};

// Fallback for a page still serving a generated script from before `_fc_gcm`. Derives the same
// answer from the cookie categories in the event, minus the IAB TCF contribution, which only the
// page can compute — a TCF visitor on an old script therefore gets the categories they chose in our
// own banner, never more than they agreed to.
const deriveFromCategories = (byId) => {
  if (!byId || typeof byId !== 'object') return undefined;
  const out = {
    ad_storage: 'denied',
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    analytics_storage: 'denied',
    functionality_storage: 'granted',
    personalization_storage: 'denied',
    security_storage: 'denied'
  };
  for (const id in CATEGORY_TO_TYPES) {
    if (byId[id] !== true) continue;
    const granted = CATEGORY_TO_TYPES[id];
    for (let i = 0; i < granted.length; i += 1) out[granted[i]] = 'granted';
  }
  for (let p = 0; p < AND_PAIRS.length; p += 1) {
    const pair = AND_PAIRS[p];
    let all = true;
    for (let r = 0; r < pair.require.length; r += 1) {
      if (byId[pair.require[r]] !== true) all = false;
    }
    if (all) out[pair.signal] = 'granted';
  }
  return out;
};

const onConsent = (event) => {
  // The parse-time stub answers an immediate `listenerRegistered` with no state attached — it has
  // none yet. Returning here is not a missed update: the bundle re-fires every adopted listener
  // with `consentChanged` / reason "cmpLoaded" as soon as it has the real answer.
  if (!event || !event.state) return;
  const state = event.state;
  // The banner is still unanswered. Saying anything now would cancel the grace period the defaults
  // above just asked for, and lock tags out of a decision the visitor has not made.
  if (state.hasChoice !== true) return;
  const signals = readPublishedSignals() || deriveFromCategories(state.categoriesById);
  if (!signals) {
    log('FlexyConsent CMP: a consent event arrived with no readable state; consent mode not updated.');
    return;
  }
  updateConsentState(signals);
};

// Once per page, not once per firing. Two listeners would each answer every change with the same
// values — harmless, but it doubles the work on every mid-page withdrawal and makes the debug
// console read like a loop.
const subscribe = () => {
  if (templateStorage.getItem('fcBound') === true) return true;
  if (typeof copyFromWindow('__fcapi') !== 'function') return false;
  templateStorage.setItem('fcBound', true);
  callInWindow('__fcapi', 'addEventListener', onConsent);
  return true;
};

// ---------------------------------------------------------------------------
// 4. The script itself, if this tag is the one loading it.
// ---------------------------------------------------------------------------

// Accepts the whole snippet URL or just the ID inside it, because both are in front of the person
// filling the field and neither is obviously the right one to paste.
const scriptIdOf = (raw) => {
  if (typeof raw !== 'string') return '';
  let value = raw.trim();
  const slash = value.lastIndexOf('/');
  if (slash !== -1) value = value.substring(slash + 1);
  if (value.indexOf('?') !== -1) value = value.substring(0, value.indexOf('?'));
  if (value.length > 3 && value.substring(value.length - 3) === '.js') {
    value = value.substring(0, value.length - 3);
  }
  value = value.toLowerCase();
  if (value.length !== 40) return '';
  for (let i = 0; i < value.length; i += 1) {
    if ('0123456789abcdef'.indexOf(value.substring(i, i + 1)) === -1) return '';
  }
  return value;
};

if (subscribe()) {
  // Already on the page — the publisher put the snippet in their source, which is the placement we
  // recommend. Nothing to inject.
  data.gtmOnSuccess();
} else if (data.loadScript !== true) {
  log('FlexyConsent CMP: window.__fcapi is not on this page. The consent defaults above were ' +
      'applied, but nothing will ever update them. Either add the FlexyConsent snippet to your ' +
      'page source ABOVE the Tag Manager container, or tick "Load the FlexyConsent script from ' +
      'this tag".');
  data.gtmOnSuccess();
} else {
  const id = scriptIdOf(data.scriptId);
  if (id === '') {
    log('FlexyConsent CMP: "Consent script ID or URL" is not a FlexyConsent script ID. Expected ' +
        'the 40-character ID from your install snippet, or the whole script URL.');
    data.gtmOnFailure();
  } else {
    // The /d/a/b/c/<id>.js fan-out: the first three characters of the ID are its directory path.
    const url = 'https://flexyconsent.com/d/' +
      id.substring(0, 1) + '/' + id.substring(1, 2) + '/' + id.substring(2, 3) + '/' + id + '.js';
    injectScript(url, () => {
      // The script defines __fcapi synchronously as it parses, so by the time this runs the stub is
      // there to subscribe to.
      if (!subscribe()) {
        log('FlexyConsent CMP: the consent script loaded but did not publish window.__fcapi. ' +
            'Check that the script ID belongs to a consent project.');
      }
      data.gtmOnSuccess();
    }, () => {
      log('FlexyConsent CMP: could not load ' + url);
      data.gtmOnFailure();
    }, url);
  }
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://flexyconsent.com/d/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "__fcapi"},
                  {"type": 8, "boolean": true},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "_fc_gcm"},
                  {"type": 8, "boolean": true},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": false}
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {"type": 1, "string": "ads_data_redaction"},
              {"type": 1, "string": "url_passthrough"}
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "ad_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "ad_user_data"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "ad_personalization"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "analytics_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "functionality_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "personalization_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "security_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: An empty defaults table still denies everything
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertApi('setDefaultConsentState').wasCalledWith({
      ad_storage: 'denied',
      ad_user_data: 'denied',
      ad_personalization: 'denied',
      analytics_storage: 'denied',
      functionality_storage: 'granted',
      personalization_storage: 'denied',
      security_storage: 'denied',
      wait_for_update: 500
    });
    assertApi('gtmOnSuccess').wasCalled();
- name: A blank wait-for-update falls back to 500 rather than to 0
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    let seen;
    mock('setDefaultConsentState', (command) => { seen = command; });

    runCode({ loadScript: false, waitForUpdate: '   ' });

    assertThat(seen.wait_for_update).isEqualTo(500);
- name: A region cell becomes a list of uppercase codes
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    let seen;
    mock('setDefaultConsentState', (command) => { seen = command; });

    runCode({
      loadScript: false,
      waitForUpdate: '500',
      defaultSettings: [{ region: 'de, fr ,ES', analytics_storage: 'granted' }]
    });

    assertThat(seen.region).isEqualTo(['DE', 'FR', 'ES']);
    assertThat(seen.analytics_storage).isEqualTo('granted');
- name: The published signals reach updateConsentState
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', (key) => {
      if (key === '__fcapi') return () => {};
      if (key === '_fc_gcm') return {
        ad_storage: 'granted',
        ad_user_data: 'granted',
        ad_personalization: 'denied',
        analytics_storage: 'granted',
        functionality_storage: 'granted',
        personalization_storage: 'denied',
        security_storage: 'denied'
      };
    });
    mock('callInWindow', (path, command, callback) => {
      assertThat(path).isEqualTo('__fcapi');
      assertThat(command).isEqualTo('addEventListener');
      callback({ eventName: 'consentChanged', state: { hasChoice: true, categoriesById: {} } });
    });

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertApi('updateConsentState').wasCalledWith({
      ad_storage: 'granted',
      ad_user_data: 'granted',
      ad_personalization: 'denied',
      analytics_storage: 'granted',
      functionality_storage: 'granted',
      personalization_storage: 'denied',
      security_storage: 'denied'
    });
- name: An unanswered banner leaves the defaults and their grace period alone
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', (key) => {
      if (key === '__fcapi') return () => {};
      if (key === '_fc_gcm') return { ad_storage: 'denied' };
    });
    mock('callInWindow', (path, command, callback) => {
      callback({ eventName: 'consentChanged', state: { hasChoice: false, categoriesById: {} } });
    });

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertApi('updateConsentState').wasNotCalled();
- name: The stub listenerRegistered event carries no state and is not an update
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', (key) => {
      if (key === '__fcapi') return () => {};
    });
    mock('callInWindow', (path, command, callback) => {
      callback({ eventName: 'listenerRegistered', listenerId: 1, cmpStatus: 'stub' });
    });

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertApi('updateConsentState').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();
- name: Without the published signals the categories give the same answer
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', (key) => {
      if (key === '__fcapi') return () => {};
      // An older generated script: no _fc_gcm on the page at all.
    });
    mock('callInWindow', (path, command, callback) => {
      callback({
        eventName: 'consentChanged',
        state: {
          hasChoice: true,
          // Essential + Marketing + Personalization accepted; Analytics and Security refused.
          categoriesById: { '1': true, '2': false, '3': true, '4': true, '5': false }
        }
      });
    });

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertApi('updateConsentState').wasCalledWith({
      ad_storage: 'granted',
      ad_user_data: 'granted',
      ad_personalization: 'granted',
      analytics_storage: 'denied',
      functionality_storage: 'granted',
      personalization_storage: 'granted',
      security_storage: 'denied'
    });
- name: ad_personalization needs BOTH Marketing and Personalization
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', (key) => {
      if (key === '__fcapi') return () => {};
    });
    mock('callInWindow', (path, command, callback) => {
      callback({
        eventName: 'consentChanged',
        state: { hasChoice: true, categoriesById: { '1': true, '3': true } }
      });
    });

    let seen;
    mock('updateConsentState', (signals) => { seen = signals; });

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertThat(seen.ad_storage).isEqualTo('granted');
    assertThat(seen.ad_personalization).isEqualTo('denied');
- name: The script URL is built from the first three characters of the ID
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    let injected;
    mock('injectScript', (url, onSuccess) => { injected = url; onSuccess(); });

    runCode({
      loadScript: true,
      waitForUpdate: '500',
      scriptId: '61946a9bb1d7c74ae4e8776ba1a13df0cb0cf835'
    });

    assertThat(injected).isEqualTo(
      'https://flexyconsent.com/d/6/1/9/61946a9bb1d7c74ae4e8776ba1a13df0cb0cf835.js');
- name: A whole snippet URL is accepted in the same field
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    let injected;
    mock('injectScript', (url, onSuccess) => { injected = url; onSuccess(); });

    runCode({
      loadScript: true,
      waitForUpdate: '500',
      scriptId: ' https://flexyconsent.com/d/6/1/9/61946a9bb1d7c74ae4e8776ba1a13df0cb0cf835.js?v=2 '
    });

    assertThat(injected).isEqualTo(
      'https://flexyconsent.com/d/6/1/9/61946a9bb1d7c74ae4e8776ba1a13df0cb0cf835.js');
- name: Something that is not a script ID fails the tag instead of requesting a wrong URL
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    runCode({ loadScript: true, waitForUpdate: '500', scriptId: 'my-project' });

    assertApi('injectScript').wasNotCalled();
    assertApi('gtmOnFailure').wasCalled();
- name: The defaults are applied even when nothing on the page can ever update them
  code: |-
    mock('templateStorage', freshStorage());
    mock('copyFromWindow', () => undefined);

    runCode({ loadScript: false, waitForUpdate: '500' });

    assertApi('setDefaultConsentState').wasCalled();
    assertApi('callInWindow').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();
setup: |-
  // templateStorage is shared by every instance of a template on a page, which is exactly what the
  // once-per-page subscription guard wants and exactly what a test suite does not: a scenario that
  // subscribes would leave the flag set for the next one, and the next one would silently assert
  // against a tag that never subscribed. Each scenario gets its own.
  const freshStorage = () => {
    const store = {};
    return {
      getItem: (key) => store[key],
      setItem: (key, value) => { store[key] = value; },
      removeItem: (key) => { store[key] = undefined; },
      clear: () => {}
    };
  };


___NOTES___

Created on 19/09/2026

