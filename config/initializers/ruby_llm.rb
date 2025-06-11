# frozen_string_literal: true

require "ruby_llm"

RubyLLM.configure do |config|
  # Default to the llama3.2:3b model.
  config.default_model = ENV.fetch("OPENAI_DEFAULT_MODEL", "llama3.2:3b")

  # Use the Rails logger.
  config.logger = Rails.logger

  # Default to the local OpenAI API provided by Ollama.
  config.openai_api_base = ENV.fetch("OPENAI_API_BASE", "http://localhost:11434/v1")
  config.openai_api_key  = ENV.fetch("OPENAI_API_KEY",  "ollama")
end

# Don't attempt to refresh the models with no environment set during asset
# compilation in development, when compiling assets in Docker, or when in the
# test environment.
if ENV["RAILS_ENV"].present? && ENV["SECRET_KEY_BASE_DUMMY"].blank? && !Rails.env.test?
  Rails.application.configure do
    config.after_initialize do
      RubyLLM.models.refresh!
    end
  end
end
