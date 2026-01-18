#!/bin/sh
# Measure execution time:

measure_time() {
  start=$(date '+%s')
  sleep 1
  end=$(date '+%s')
  elapsed=$((end - start))
  echo "Elapsed: ${elapsed}s"
}
echo "Execution timing:"
measure_time
