import express, { urlencoded, json } from 'express'
import 'dotenv/config'
import api from './api'

const app = express()

app.use(urlencoded({ extended: true }))
app.use(json())

app.use(api)

module.exports = app
