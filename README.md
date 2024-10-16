# sandbox.sol

Super simple (~59 LOC) contract for sandboxing arbitrary calls. Its purpose is to ensure any arbitrary calls do not run under a contract's identity, meaning it cannot arbitrarily transferFrom or fuck with stuff as that contract.

**This DOES NOT block returnbomb attacks. If you want that, write your own with excessivelySafeCall.**

UNAUDITED AND UNTESTED CODE BUT I HOPE IT'S SAFE. SPEND A FEW BUCKS ON AN AUDIT IF YOU'RE SECURING BILLIONS.

## Installation & Use

```
bun install https://github.com/0xlynett/sandbox.sol
```

Then add the following to your remappings:

```
sandbox.sol=node_modules/sandbox.sol/Sandbox.sol
```
