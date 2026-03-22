#!/bin/bash

echo "Running SIEM simulation..."

# Brute force
FAIL=$(grep "Failed password" ../logs/auth.log | wc -l)
if [ $FAIL -gt 2 ]; then
  echo "ALERT: Brute force detected" >> ../alerts/alerts.log
fi

# Suspicious login
if grep -q "unknown_user" ../logs/auth.log; then
  echo "ALERT: Suspicious login" >> ../alerts/alerts.log
fi

# CPU anomaly
if grep -q "CPU usage high" ../logs/system.log; then
  echo "ALERT: High CPU usage" >> ../alerts/alerts.log
fi

# Memory
if grep -q "Out of memory" ../logs/system.log; then
  echo "ALERT: Memory issue" >> ../alerts/alerts.log
fi

echo "SIEM simulation complete."
