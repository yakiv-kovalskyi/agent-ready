# Principles

The project-agnostic practices for working well with AI agents on code. Each is
short, each earns its place, and each traces back to a real way things go wrong.
Adopt what fits; don't cargo-cult what you don't need yet.

## 1. Verify, don't assume
"Tests pass" is not "it works." Exercise the actual change end to end and observe
the behavior. For a bug fix, first confirm the test *fails without the fix* &mdash;
a test that passes on the buggy code proves nothing. Prove it, then claim it.

## 2. Silence is never consent
Before anything irreversible or outward-facing &mdash; publishing, deleting,
sending, deploying, merging, changing access &mdash; get an explicit "yes." A
missing objection is not approval. Consent is per-action and per-session; one
approval does not generalize to the next.

## 3. Green at your branch is not green at the merge
Checks passing on your branch say nothing about the state you're merging into.
Re-verify against the current tip before integrating. A stale green is not green.

## 4. Arming the gate is walking through it
Don't automate an irreversible step and call it "just setup." Auto-merge fires
without re-reading the room; scheduling a deploy is deploying. If it can't be
undone, a human decides at the moment it happens.

## 5. Attribute by evidence, not inference
When more than one actor touches the work &mdash; several agents, a shared
identity, a team &mdash; "it changed while X was active" is not attribution. Read
the history, the diff, the branch. Assign credit and blame from evidence.

## 6. Say what actually happened
Report faithfully. If tests failed, show the output. If a step was skipped, say
so. State done-and-verified plainly; state uncertainty as uncertainty. An agent
that smooths over failure is worse than one that fails loudly.

## 7. Keep secrets and personal data out of everything shared
No credentials, tokens, or personal data in the repo, logs, commit messages,
issues, or published artifacts. Scan before you publish. Assume anything shared
is permanent and public.

## 8. Security-sensitive changes get a gate that can catch the bug
For auth, tokens, crypto, sessions, and access control: review before merge, and
make sure the tests can actually fail on the vulnerability. A test that signs its
own fixtures with the key the code trusts proves nothing &mdash; it will pass on a
forged input too. If a test can't go red on the real bug class, it isn't a gate.

## 9. Right-size the process (the one that governs the rest)
Every rule, gate, and ritual is complexity, and complexity must pull its weight.
Add a practice when a real failure demands it, not because it looks rigorous.
Much coordination overhead exists to solve problems you may not have. If a gate
is perpetually "pending" and never catches anything, that's a smell, not a
safeguard &mdash; remove what stopped paying rent.

## 10. Write down what you'd otherwise re-derive
Durable, non-obvious facts &mdash; decisions, gotchas, the *why* behind a choice
&mdash; belong in persistent memory, not a chat that vanishes. Keep them current;
delete them when they turn out to be wrong. A stale note is worse than none.
