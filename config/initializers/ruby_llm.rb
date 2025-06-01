# frozen_string_literal: true

require "ruby_llm"

RubyLLM.configure do |config|
  config.default_model   = ENV.fetch("OPENAI_DEFAULT_MODEL", "llama3.2:3b")
  config.openai_api_base = ENV.fetch("OPENAI_API_BASE",      "http://localhost:11434/v1")
  config.openai_api_key  = ENV.fetch("OPENAI_API_KEY",       "ollama")
end

unless Rails.env.test?
  Rails.application.configure do
    config.after_initialize do
      RubyLLM.models.refresh!
    end
  end
end
