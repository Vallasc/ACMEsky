#!/usr/bin/env node;

import express from 'express';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';
import axios from 'axios';

const app = express();
const argv = yargs(hideBin(process.argv))
  .scriptName("GeographicalDistance")
  .usage('$0 -p [port] -a [api]')
  .alias("p", "port")
    .default("p", 3000)
  .help("h")
  .alias("h", "help")
  .argv;

const PORT = argv.port;


app.get('/distance', (req, res) => {
  const { from, to } = req.query;
  if (!from || !to){
    res.status(400).json({error : "missing [from] or [to] parameter"});
    return;
  }

  axios.get('https://www.distanza.org/route.json?stops=' + from + '|' + to)
  .then(response => {
    //console.log(response.data.distance);
    res.status(200).json({distance : response.data.distance});
  })
  .catch(e => {
    console.log(e);
    res.status(400).json({error: "internal error"});
  });
});

app.listen(PORT, () => {
  console.log(`GeographicalDistance listening on port:${PORT}`);
});