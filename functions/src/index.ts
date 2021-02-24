// functions

if (!process.env.FUNCTION_TARGET || process.env.FUNCTION_TARGET === 'matching') {
  exports.matching = require('./routes/matching')
}

// pubsub

if (!process.env.FUNCTION_TARGET || process.env.FUNCTION_TARGET === 'pubsubMatching') {
  exports.pubsubMatching = require('./routes/pubsub/matching')
}
