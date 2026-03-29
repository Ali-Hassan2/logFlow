import z from 'zod'
import { ACCOUNT_USECASES, APP_ROLES } from '../constants/constants'

const fullNameSchema = z.string().min(3, {
  message: 'Name should be 3 characters long.',
})
const emailSchema = z.string().email({
  message: 'Invalid Email Address.',
})
const passwordSchema = z.string().min(4, {
  message: 'Password must be 4 characters long.',
})
const companyNameSchema = z.string({
  message: 'Comapany name should be valid',
})
const useCaseSchema = z.enum(Object.values(ACCOUNT_USECASES)).optional()
const roleSchema = z.enum(Object.values(APP_ROLES))
const imageSchema = z.string()

const accountCreationSchema = z.object({
  fullName: fullNameSchema,
  email: emailSchema,
  password: passwordSchema,
  companyName: companyNameSchema,
  role: roleSchema,
  useCase: useCaseSchema,
  iamge: imageSchema,
})

export { accountCreationSchema }
