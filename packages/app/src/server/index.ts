import express from 'express'
import * as dotenv from 'dotenv'
import api from './api'

dotenv.config()

const app = express()

app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.use(api)

module.exports = app
