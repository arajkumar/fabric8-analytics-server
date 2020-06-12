#!/bin/bash

# Start API backbone service with time out
gunicorn --pythonpath /app -b 0.0.0.0:5000 -t 1000 -k sync --access-logformat '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"' --access-logfile - --error-logfile - --log-level debug -w 4 bayesian:app
