# This isn't necessary, but Hash#fetch raises a KeyError, and putting this in an
# initializer means the deploy will fail, rather than deploying broken code that
# relies on this ENV value to be executed.
API_SESSIONS_SECRET = ENV.fetch("API_SESSIONS_SECRET")
