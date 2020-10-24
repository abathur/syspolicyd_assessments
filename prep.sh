set -x
echo "NIX_SSL_CERT_FILE=/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt" >> $GITHUB_ENV
export NIX_SSL_CERT_FILE=/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt
sudo launchctl setenv NIX_SSL_CERT_FILE "$cert_file"
echo "/nix/var/nix/profiles/per-user/$USER/profile/bin" >> $GITHUB_PATH || true
echo "/nix/var/nix/profiles/default/bin" >> $GITHUB_PATH || true
if test -f $HOME/.nix-profile/etc/profile.d/nix.sh; then
	source $HOME/.nix-profile/etc/profile.d/nix.sh
fi
