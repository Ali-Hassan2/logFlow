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

const ACCOUNT_USECASES = Object.freeze({
  STARTUP: 'startup',
  PERSONAL: 'personal',
  ENTERPRISE: 'enterprise',
  EDUCTION: 'education',
  SIDE_PROJECT: 'sideProject',
} as const)

const APP_ROLES = Object.freeze({
  ADMIN: 'admin',
  USER: 'user',
} as const)

const ACCOUNT_TYPES = Object.freeze({
  FREE: 'free',
  BASIC: 'basic',
  STANDARD: 'standard',
  PREMIUM: 'premium',
} as const)

export {
  LimiterTime,
  rateLimitErrorMessage,
  MORGAN_MODS,
  SERVER_ENV,
  ACCOUNT_USECASES,
  APP_ROLES,
  ACCOUNT_TYPES,
}
