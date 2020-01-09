#!/bin/bash
echo "{\"account_id\": \"`aws sts get-caller-identity --output text --query 'Account'`\"}"
