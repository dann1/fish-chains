# default key sequence: Ctrl+s
set -q chains_sequence
  or set -l chains_sequence \eq

# if chains is already bound to some sequence, leave it
test (bind | grep -q '[[:space:]]chains$')
  or set -l do_bind

# not bound but sequence already taken?
if test (bind $chains_sequence ^/dev/null)
  echo "chains: The requested sequence is already in use:" (bind $chains_sequence | cut -d' ' -f2-)
else if set -q do_bind
  bind $chains_sequence chains
end