# NixOS Config

note: this is intended for personal use only

## Installation
Run the bootstrap script:
```bash
bash bootstrap.sh
```

## Post-install
1. Restart the system.
2. Adjust display scale to 150%
3. Generate SSH key:
```bash
ssh-keygen -t ed25519 -C ajlouni2000@gmail.com
```
4. Authenticate with GitHub:
```bash
gh auth login
```
