import rateLimit from 'express-rate-limit'
import { LimiterTime, rateLimitErrorMessage } from '../constants/constants'

const isProduction = process.env.NODE_ENV === 'production'

const limiter = rateLimit({
  windowMs: LimiterTime,
  max: isProduction ? 100 : 1000,
  legacyHeaders: false,
  standardHeaders: true,
  message: rateLimitErrorMessage,
})

export { limiter }
