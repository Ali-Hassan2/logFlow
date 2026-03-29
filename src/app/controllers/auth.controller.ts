import { Request, Response } from 'express'

export class AuthController {
  static async createAccount(req: Request, res: Response) {
    try {
      const { fullName, email, password, companyName, useCase } = req.body

      const account = await AuthService.createAccount({
        fullName,
        email,
        password,
        companyName,
        useCase,
      })

      return res.status(201).json({
        message:
          'Account created successfully. Verification code sent to email.',
        accountId: account.id,
      })
    } catch (err: any) {
      return res.status(400).json({ error: err.message })
    }
  }

  static async login(req: Request, res: Response) {
    try {
      const { email, password } = req.body

      const token = await AuthService.login({ email, password })

      return res.status(200).json({
        message: 'Login successful',
        token,
      })
    } catch (err: any) {
      return res.status(401).json({ error: err.message })
    }
  }

  static async verifyAccount(req: Request, res: Response) {
    try {
      const { email, verificationCode } = req.body

      const success = await AuthService.verifyAccount({
        email,
        verificationCode,
      })

      if (success) {
        return res
          .status(200)
          .json({ message: 'Account verified successfully' })
      } else {
        return res
          .status(400)
          .json({ error: 'Invalid or expired verification code' })
      }
    } catch (err: any) {
      return res.status(400).json({ error: err.message })
    }
  }
}
