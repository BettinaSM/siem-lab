#!/bin/bash

echo "Running SIEM simulation..."

# Clear previous alerts
> ../alerts/alerts.log

# Brute force detection
FAIL=$(grep "Failed password" ../logs/auth.log | wc -l)

if [ $FAIL -gt 2 ]; then
  echo "ALERT [HIGH]: Brute force attack detected from 192.168.1.10" >> ../alerts/alerts.log
fi

# Suspicious login correlation
if grep -q "unknown_user" ../logs/auth.log && [ $FAIL -gt 2 ]; then
  echo "ALERT [CRITICAL]: Possible account compromise after brute force" >> ../alerts/alerts.log
fi

# CPU anomaly
if grep -q "CPU usage high" ../logs/system.log; then
  echo "ALERT [MEDIUM]: High CPU usage detected" >> ../alerts/alerts.log
fi

# Memory anomaly
if grep -q "Out of memory" ../logs/system.log; then
  echo "ALERT [HIGH]: System memory issue detected" >> ../alerts/alerts.log
fi

echo "SIEM simulation complete."
