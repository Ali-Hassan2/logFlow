const LimiterTime = 15 * 60 * 1000

const rateLimitErrorMessage =
  'Sorry there are too many requests cannot manage these at the same time.'

const MORGAN_MODS = {
  COMBINED: 'combined',
  DEV: 'dev',
}

const SERVER_ENV = {
  PRODUCTION: 'production',
  DEV: 'dev',
  SAT: 'sat',
}

export { LimiterTime, rateLimitErrorMessage, MORGAN_MODS, SERVER_ENV }
