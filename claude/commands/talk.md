---
description: Start a voice conversation, optionally with context
argument-hint: [context or topic]
---

Start a voice conversation with me.

1. Whisper and Kokoro don't autostart. Start both with the VoiceMode `service` tool
   (`action: start`, `service_name: whisper`, then `kokoro`), skipping one that is already running.
   Wait for Kokoro to report running before speaking.
2. Converse using the VoiceMode `converse` tool.

Context for the conversation: $ARGUMENTS

If no context is given, use what we've been working on in this session.
