#!/usr/bin/env bash

# --- Function to check command success and exit if it fails (Fail Fast Principle) ---
check_status() {
  if [ $? -ne 0 ]; then
    echo "ERROR: Quality Gate failed at stage: $1"
    exit 1
  fi
}


echo "========================================================"
echo "  Starting Continuous Testing Pipeline: Billing Service"
echo "========================================================"

#---

echo -e "STAGE 1: Build/Code (Unit Tests & Static Analysis)"
echo

# TDD-driven Unit Tests (Fastest tests first)
echo "Running Pytest Unit Tests..."
pytest -k "not integration" # Run unit tests only, excluding integration tests
check_status "Unit Test Execution"


echo -e "STAGE 2: Staging/Integration (Integration Checks)"
echo
# Integration Test (Using Mocks to verify contract)
echo "Running Pytest Integration Tests (using Mocked database call)..."
pytest test_integration.py
check_status "Integration Test Execution"


echo -e "STAGE 3: Deployment"
echo

echo "All quality gates passed. Ready for deployment to Production."
echo "Deployment simulation complete."
echo
echo "========================================================="
echo "  Pipeline Success: Code is validated and ready to ship!"
echo "========================================================="
