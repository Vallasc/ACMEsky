const { any } = require('@hapi/joi');
const mongoose = require ('mongoose');
const subscriptionSchema = new mongoose.Schema ({
  info:{
  }
});

module.exports = mongoose.model ('Subscription', subscriptionSchema);