class authController {
  static async createAccount(req: Request, res: Response) {
    const body = req.body
    console.log('The body data:', body)
  }
}
