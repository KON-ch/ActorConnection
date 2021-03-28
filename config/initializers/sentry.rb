# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://e0b96cce2cb243678d6f5e3aa5d2106a@o560024.ingest.sentry.io/5695320'
  config.breadcrumbs_logger = [:active_support_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
