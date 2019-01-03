function deduplicate_path --description 'Removes duplicate entries from $PATH'
  set -l new_path
  for p in $PATH
    if not contains $p $new_path
      set new_path $new_path $p
    end
  end
  set PATH $new_path
end
