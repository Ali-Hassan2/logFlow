import {
  ACCOUNT_TYPES,
  ACCOUNT_USECASES,
  APP_ROLES,
} from '../constants/constants'

const accountsData = [
  {
    fullName: 'John Doe',
    email: 'john.doe@example.com',
    companyName: 'Doe Tech',
    password: '$2b$10$PLACEHOLDER_HASH1',
    useCase: ACCOUNT_USECASES.ENTERPRISE,
    role: APP_ROLES.ADMIN,
    isVerifiedAccount: true,
    accountSubscriptions: {
      create: [
        {
          paidStatus: false,
          freePlanEnabled: true,
          PaidType: ACCOUNT_TYPES.FREE, // For free accounts
          PaidMaxAppLimits: 3,
          startDate: new Date('2026-03-29T00:00:00.000Z'),
          endDate: new Date('2026-04-29T00:00:00.000Z'),
          renewalData: new Date('2026-04-29T00:00:00.000Z'),
          autoRenew: false,
          lastPaymentId: 0, // <--- must provide something
        },
      ],
    },
  },
  {
    fullName: 'Jane Smith',
    email: 'jane.smith@example.com',
    companyName: 'Smith Solutions',
    password: '$2b$10$PLACEHOLDER_HASH2',
    useCase: ACCOUNT_USECASES.PERSONAL,
    role: APP_ROLES.USER,
    isVerifiedAccount: true,
    accountSubscriptions: {
      create: [
        {
          paidStatus: false,
          freePlanEnabled: true,
          PaidType: ACCOUNT_TYPES.FREE,
          PaidMaxAppLimits: 3,
          startDate: new Date('2026-03-29T00:00:00.000Z'),
          endDate: new Date('2026-04-29T00:00:00.000Z'),
          renewalData: new Date('2026-04-29T00:00:00.000Z'),
          autoRenew: false,
          lastPaymentId: 0, // <--- required
        },
      ],
    },
  },
]

export { accountsData }
