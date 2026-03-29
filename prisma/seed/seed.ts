import { prisma } from '../../src/prisma'
import { accountsData } from '../../src/app/account'

const seedData = async () => {
  try {
    for (const account of accountsData) {
      await prisma.account.create({
        data: account,
      })
    }
    console.log('Seeding completed successfully')
  } catch (error) {
    console.error('Seeding failed:', error)
    process.exit(1)
  } finally {
    await prisma.$disconnect()
  }
}

seedData()
