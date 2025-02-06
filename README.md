# SQL Race Condition in Bank Transfer

This repository demonstrates a subtle race condition in a seemingly simple SQL query for transferring money between bank accounts.  The core issue lies in the lack of proper concurrency control when checking account balances before updating them.

## The Bug
The `bug.sql` file contains a SQL query that attempts to transfer funds between accounts.  However, the query lacks necessary locking mechanisms to prevent concurrent updates from interfering with the transfer, potentially resulting in failed transactions or incorrect balances.

## The Solution
The `bugSolution.sql` file presents a corrected version of the query that uses transactions and appropriate locking to avoid race conditions. This ensures data consistency and prevents incorrect results from concurrent operations.

## How to Reproduce
The race condition can be reliably reproduced by running the `bug.sql` script concurrently with another script that modifies the involved account balances.  The solution file provides a more robust way to handle such transactions.