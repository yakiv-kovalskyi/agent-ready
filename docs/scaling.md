# Scaling to multiple agents (optional)

**Adopt this only if several agents (or people + agents) work in the same repo at
once, and you actually feel the collisions.** For a single developer with an
assistant, it's overhead &mdash; skip it until it hurts. (See principle 9.)

Each rule below was paid for by a real collision, not designed up front. That's
the point: let incidents write the rules.

## Isolate the work
Give each agent its own branch or worktree. Two agents editing one checkout will
silently overwrite each other's work.

## Claim before you build
Before starting a task, check that no one else has claimed it &mdash; an open
branch, a PR, a comment. Then claim it visibly. Duplicated work is the most
common waste.

## One integrator
Route all merges through a single point (a person or a designated role). Parallel
mergers stack changes that were never validated together.

## Sequence changes to shared files
Two changes that are each green alone can be broken together. When they touch the
same files, merge one, re-verify, then the next.

## Coordinate through durable artifacts
Live messages between agents cross in flight and get lost. Put anything that
matters where it persists &mdash; a comment, a status, a claim &mdash; with
timestamps and specifics, so a message that arrives late is still unambiguous.

## Let incidents write the rules
Don't add coordination rules speculatively. When something collides, capture the
lesson as a one-line rule linked to the incident. A short ledger of
"what went wrong &rarr; the rule it wrote" keeps the process honest and minimal
&mdash; and tells you when a rule's cause is gone and the rule can go too.
