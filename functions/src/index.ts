// pubsub

if (!process.env.FUNCTION_TARGET || process.env.FUNCTION_TARGET === 'cron') {
  exports.cron = require('./routes/pubsub/cron/index')
}
