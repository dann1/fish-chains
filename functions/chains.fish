function chains -d "Quickly toggle proxychains prefix"

  # Save the current command line and cursor position.
  set -l command_buffer (commandline)
  set -l cursor_position (commandline -C)

  # If the command line is empty, pull the last command from history.
  if test -z $command_buffer
    set command_buffer $history[1]
  end

  # Parse the command line.
  set -l command_parts (string match -ir '^(\s*)(proxychains -q(\s+|$))?(.*)' $command_buffer)

  switch (count $command_parts)
    case 3
      # No "chains".

      # Add "chains" to the beginning of the command, after any leading whitespace (if present).
      commandline -r (string join '' $command_parts[2] 'proxychains -q ' $command_parts[3])

      # Push the cursor position ahead if necessary (+15 for 'chains ').
      test $cursor_position -ge (string length $command_parts[2])
        and set cursor_position (math $cursor_position+15)

      # Place the cursor where it was (or where it should be).
      commandline -C $cursor_position

    case 5
      # "chains" is present in the beginning of the command.

      # Remove "chains", leave any leading whitespace (if present).
      commandline -r (string join '' $command_parts[2 5])

      # Push the cursor position back if appropriate ('chains' and whitespace).
      set -l lead_length (string length $command_parts[2])
      set -l chains_length (string length $command_parts[3])
      if test $cursor_position -ge (math $lead_length+$chains_length)
        # The cursor was after "chains".
        set cursor_position (math $cursor_position-$chains_length)
      else if test $cursor_position -ge $lead_length
        # The cursor was somewhere on "chains".
        set cursor_position $lead_length
      end

      # Place the cursor where it was (or where it should be).
      commandline -C -- $cursor_position
  end
end
