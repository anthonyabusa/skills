---
name: write-swift
description: "Write, review or migrate Swift the modern way: value types first, Swift 6 strict concurrency (main actor by default, async/await over completion handlers, actors, structured tasks), some over any, Swift Testing, os Logger, plus two traps that cost real debugging time (SIGTRAP from a completion handler on a @MainActor type, swift build hanging on the keychain). Use when touching Swift or chasing a Swift crash, hang, data race or concurrency warning."
---

Prevents: pre-Swift-6 code (completion handlers, DispatchQueue hops, unchecked Sendable) that crashes or races under strict concurrency, and builds that hang under launchd or ssh.
Use when: any Swift change.
Not for: picking UI direction (prototype) or motion values (motion).

## Step 1: Model with value types
- Default to `struct` and `enum`; use `class` only for identity, shared mutable state or resource lifetime. `let` unless it must change.
- Make illegal states unrepresentable: an enum with associated values beats several optionals that must agree.
- `some P` by default; `any P` only for heterogeneous storage.

## Step 2: Concurrency, in this order
- App code runs on the main actor (enable main-actor-by-default for app targets). Mutable UI-facing state lives in a `@MainActor` class, often `@Observable`.
- Replace completion handlers with the async API (`try await URLSession.shared.data(from:)`). Delete `DispatchQueue.main.async` hops; the actor isolation does that job.
- Move work off the main actor only after profiling shows a hang: `@concurrent` functions for CPU work, an `actor` for shared state touched from many tasks.
- Prefer structured tasks (`async let`, `withTaskGroup`); avoid `Task.detached`. One `Task` per user action, cancelled when its view goes away. Re-check state after every `await`.
- `@unchecked Sendable` only on a type with real internal locking (`Mutex`), with a comment saying which lock.

## Step 3: Two traps worth knowing
- SIGTRAP in "closure #N in <SomeType>" where the type is `@MainActor`: an Apple completion handler ran on a background queue and hit the actor check. Fix by switching to the async variant of that API, not by sprinkling `nonisolated`. Test the bundled .app, because `swift build` alone does not reproduce it.
- `swift build` under launchd or ssh stalls at 0% CPU on artifact download after a keychain error (-25308): run `swift build --disable-keychain` under a timeout (`timeout 600 swift build --disable-keychain`).

## Step 4: Errors, logging, tests
- `throw` for recoverable errors, `precondition` for programmer mistakes. No force-unwraps outside tests.
- Log with `Logger` from `os`, not `print`; interpolated values are private unless marked `privacy: .public`. Never log secrets or money.
- Tests use Swift Testing: `@Test`, `#expect`, `try #require`, `@Test(arguments:)` for tables. Tests run in parallel; fix shared state instead of serializing.

## Step 5: Migrate a target to Swift 6
- One target at a time: turn on complete concurrency checking, fix warnings cheapest first, then flip the language mode. Never mix a refactor into the same change.

## Step 6: Verify
- `swift build -Xswiftc -strict-concurrency=complete` (or Swift 6 mode): zero new warnings in touched files.
- Run `swift test` if the package has tests.
- For an app, launch the bundled app and exercise the changed path; a clean build is not proof it runs.

## Done when
- Touched files have no completion-handler APIs where an async one exists, and no `DispatchQueue.main` hops.
- The strict-concurrency build is warning-free for touched files, and tests pass.
- The changed path was exercised in the running app, or the report says plainly why it could not be.

Adapted from emilkowalski/skills write-swift (MIT).
