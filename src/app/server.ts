import express from 'express'
import morgan from 'morgan'
import hpp from 'hpp'
import dotenv from 'dotenv'
import helmet from 'helmet'
import cookieParser from 'cookie-parser'
import cors from 'cors'
import colors from 'colors'
import { limiter } from '../utils/limiter'
import { MORGAN_MODS, SERVER_ENV } from '../constants/constants'

const app = express()
dotenv.config()

const port = process.env.PORT || 8001
const isProduction = process.env.NODE_ENV === SERVER_ENV.PRODUCTION
const AllowedClient = process.env.CLINET_URL

app.use(express.json())
app.use(
  cors({
    origin: isProduction ? AllowedClient : '*',
    credentials: true,
  }),
)
app.use(morgan(isProduction ? MORGAN_MODS.COMBINED : MORGAN_MODS.DEV))
app.use(hpp())
app.use(cookieParser())
app.use(limiter)
if (isProduction) {
  app.use(helmet())
}

app.get('/', (req, res) => {
  res.send({
    username: 'dummy',
    email: 'dummy@gmail.com',
  })
})

let server: any

const startServer = () => {
  return new Promise((resolve, reject) => {
    try {
      server = app.listen(port, () => {
        console.log(colors.bgRed(`Server is running at port: ${port}`))
      })
      resolve(server)
    } catch (error: unknown) {
      let serverLaunchingErrorMessage = 'Internal Server Error'
      if (typeof serverLaunchingErrorMessage === 'string') {
        serverLaunchingErrorMessage = 'Unknown event occured'
        console.log(
          colors.bgRed(
            `There is an Error while starting Server: ${serverLaunchingErrorMessage}`,
          ),
        )
      }
      reject(error)
      process.exit(1)
    }
  })
}

const shutDownServer = () => {
  console.log('The Server is cooling down.')
  if (server) {
    server.close(() => {
      console.log('Server closed.')
    })
    process.exit(0)
  }
}

process.on('SIGINT', shutDownServer)
process.on('SIGTERM', shutDownServer)

startServer()
