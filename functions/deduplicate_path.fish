function deduplicate_path --description 'Removes duplicate entries from $PATH'
  set -l new_path
  for path_element in $PATH
    if not contains $path_element $new_path
      set new_path $new_path $path_element
    end
  end
  set PATH $new_path
end
