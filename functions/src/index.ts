// pubsub

if (!process.env.FUNCTION_TARGET || process.env.FUNCTION_TARGET === 'pubsubMatching') {
  exports.pubsubMatching = require('./routes/pubsub/matching/index')
}
