#!/usr/bin/env node;

import express from 'express'
import yargs from 'yargs'
import { hideBin } from 'yargs/helpers'
import axios from 'axios'

const app = express()
const argv = yargs(hideBin(process.argv))
  .scriptName("GeographicalDistance")
  .usage('$0 -p [port] -k [api-key]')
  .alias("p", "port")
    .default("p", 80)
  .alias("k", "key")
    .default("k", "")
  .help("h")
  .alias("h", "help")
  .argv

const PORT = argv.port
const API_KEY = argv.key

app.get('/distance', async (req, res) => {
    let { from, to } = req.query
    if (!from || !to){
        res.status(400).json({error : "Missing [from] or [to] parameter"})
        return;
    }
    from = encodeURIComponent(from)
    to = encodeURIComponent(to)

    let distance
    try {
        distance = await axios.get('https://api.distancematrix.ai/maps/api/distancematrix/json', 
                                { params: { origins: from, destinations: to, key: API_KEY } })
    } catch (err) {
        console.error(err)
        res.status(400).json({error: "Internal error"})
    }
    //console.log(JSON.stringify(distance.data))
    let stringDistance = distance.data.rows[0].elements[0].distance.text
    let value = distance.data.rows[0].elements[0].distance.value
    let status = distance.data.rows[0].elements[0].status
    res.status(200).json({status: status, distance: stringDistance, value: value})

});

app.listen(PORT, () => {
    console.log(`GeographicalDistance listening on port:${PORT}`)
});