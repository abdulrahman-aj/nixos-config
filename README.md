# NixOS Config

## Installation
Run the bootstrap script:
```bash
bash bootstrap.sh
```

## Post-install
1. Restart the system.
2. Generate SSH key:
```bash
ssh-keygen -t ed25519 -C ajlouni2000@gmail.com
```
3. Authenticate with GitHub:
```bash
gh auth login
```
