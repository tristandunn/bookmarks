# frozen_string_literal: true

# Run using the `bin/ci` script.

CI.run do
  step "Setup", "bin/setup --skip-server"

  step "Style: Ruby", "bin/rubocop"
  step "Style: ERB", "bin/rails erb:lint"
  step "Style: CSS", "yarn lint:css"
  step "Style: JavaScript", "yarn lint"

  step "Security: Importmap vulnerability audit", "bin/importmap audit"
  step "Security: Brakeman code analysis",
       "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Tests: JavaScript", "yarn test:coverage"
  step "Tests: Rails", "env CI=1 bin/rails spec"
end
