function fish_git_prompt_repo_info --description 'Get the repository info.'
    for line in (command git rev-parse --git-dir --is-inside-git-dir \
                                       --is-bare-repository 2> /dev/null)
        echo $line
    end
end

function fish_git_prompt_state_info \
    --description 'Return git operation and branch'
    # This is passed the full repo info array
    set --local git_dir $argv[1]
    set --local inside_git_dir $argv[2]
    set --local bare_repo $argv[3]

    # Output variables
    set --local branch
    set --local operation
    set --local detached false
    set --local dir_warning
    set --local last_tag (command git describe --tags --abbrev=0 2> /dev/null)

    # Helper variables
    set --local step
    set --local total
    set --local op_status

    # Read the current operation and some additional info from git files.
    if test -d $git_dir/rebase-merge
        set step (cat $git_dir/rebase-merge/msgnum 2> /dev/null)
        set total (cat $git_dir/rebase-merge/end 2> /dev/null)
        if test -f $git_dir/rebase-merge/interactive
            set operation REBASE-i
        else
            set operation REBASE-m
        end
    else
        if test -d $git_dir/rebase-apply
            set step (cat $git_dir/rebase-apply/next 2> /dev/null)
            set total (cat $git_dir/rebase-apply/last 2> /dev/null)
            if test -f $git_dir/rebase-apply/rebasing
                set operation REBASE
            else if test -f $git_dir/rebase-apply/applying
                set operation AM
            else
                set operation AM/REBASE
            end
        else if test -f $git_dir/MERGE_HEAD
            set operation MERGING
        else if test -f $git_dir/CHERRY_PICK_HEAD
            set operation CHERRY-PICKING
        else if test -f $git_dir/REVERT_HEAD
            set operation REVERTING
        else if test -f $git_dir/BISECT_LOG
            set operation BISECTING
        end
    end

    # If there are steps and total, add it do the operation
    if test -n "$step" -a -n "$total"
        set operation "$operation $step/$total"
    end

    # Get a ref name to show.
    # First, set the branch name from a symbolic ref.
    set branch (command git symbolic-ref --short HEAD 2> /dev/null
              set op_status $status)
    if test -n "$op_status" -a "$op_status" -ne 0
        # If the symbolic ref check returned non-zero, we are in detached head
        # state.
        set detached true
        # Instead get the closest newer ref name (branch or tag).
        set branch (command git describe --contains --all HEAD 2> /dev/null
                set op_status $status)
        if test -n "$op_status" -a "$op_status" -ne 0
            # If this fails for some other reason, we just show the SHA of the
            # commit.
            set branch (command git rev-parse --short HEAD 2> /dev/null
                  set op_status $status)
            if test -n "$op_status" -a "$op_status" -ne 0
                # If even that fails, use "unknown".
                set branch unknown
            end
        end
    end

    # Check if we are inside a git dir or if the repo is a bare repo.
    if test "$inside_git_dir" = true
        if test "$bare_repo" = true
            set dir_warning BARE
        else
            set dir_warning 'GIT DIR'
        end
    end

    echo $operation
    echo $branch
    echo $detached
    echo $dir_warning
    echo $last_tag
end

function fish_git_prompt_dirty --description 'Get the count of dirty files.'
    echo (command git diff --name-only --diff-filter=u 2> /dev/null | wc -l)
end

function fish_git_prompt_staged --description 'Get the count of staged files.'
    echo (command git diff --staged --name-only 2> /dev/null | wc -l)
end

function fish_git_prompt_unmerged \
    --description 'Get the count of unmerged files.'
    echo (command git diff --name-only --diff-filter=U 2> /dev/null | wc -l)
end

function fish_git_prompt_untracked \
    --description 'Get the count of untracked files.'
    echo (command git ls-files --others --exclude-standard -- \
                    (command git rev-parse --show-toplevel) 2> /dev/null | \
        wc -l)
end

function fish_git_prompt_stashed --description 'Get the count of stashes.'
    echo (command git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
end

function fish_git_prompt_upstream --description 'Get upstream information'
    command git rev-list --count --left-right --cherry-mark \
        '@{upstream}'...HEAD 2>/dev/null | read --local behind ahead cherry_equal
    echo $behind
    echo $ahead
    echo $cherry_equal
end

function fish_git_prompt --description 'Write out the git part of the prompt'
    # First check if git is installed. If not exit with error.
    if not command --query git
        return 1
    end

    # Get the potential repository information to parse.
    set --local repo_info (fish_git_prompt_repo_info)

    # Check if inside a git repository and exit silently, if not.
    test -n "$repo_info"
    or return 0

    # Get some ref information.
    set --local state_info (fish_git_prompt_state_info $repo_info)
    set --local operation $state_info[1]
    set --local branch $state_info[2]
    set --local detached $state_info[3]
    set --local dir_warning $state_info[4]
    set --local last_tag $state_info[5]

    # Prepare some variables
    set --local dirty (fish_git_prompt_dirty)
    set --local staged (fish_git_prompt_staged)
    set --local unmerged (fish_git_prompt_unmerged)
    set --local stashes (fish_git_prompt_stashed)
    set --local untracked (fish_git_prompt_untracked)

    set --local upstream_info (fish_git_prompt_upstream)
    set --local behind $upstream_info[1]
    set --local ahead $upstream_info[2]
    set --local cherry_equal $upstream_info[3]

    # write the status line part
    set_color $material_grey_50 --background $material_grey_700
    echo -n ' '

    if test -n "$dir_warning"
        set_color $material_orange_500
        echo -n $dir_warning
        set_color $material_grey_300
        echo -n '  '
        set_color $material_grey_50
    end

    if test -n "$operation"
        set_color $material_orange_500
        echo -n $operation
        set_color $material_grey_300
        echo -n '  '
        set_color $material_grey_50
    end

    if test -n "$last_tag"
        set_color $material_yellow_600
        echo -n $last_tag
        set_color $material_grey_300
        echo -n '  '
        set_color $material_grey_50
    end

    if test -n "$branch"
        if test "$detached" = true
            set_color $material_red_A100
        end
        echo -n $branch
        if test "$detached" = true
            set_color $material_grey_50
        end
        echo -n ' '
    end

    if test -n "$behind" -a "$behind" -ne 0
        set_color $material_light_blue_A100
        echo -n "↓$behind"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$ahead" -a "$ahead" -ne 0
        set_color $material_light_blue_A100
        echo -n "↑$ahead"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$cherry_equal" -a "$cherry_equal" -ne 0
        set_color $material_light_blue_A100
        echo -n "🍒$cherry_equal"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$staged" -a "$staged" -ne 0 -o \
            -n "$dirty" -a "$dirty" -ne 0 -o \
            -n "$stashes" -a "$stashes" -ne 0 -o \
            -n "$untracked" -a "$untracked" -ne 0
        set_color $material_grey_300
        echo -n ' '
        set_color $material_grey_50
    end

    if test -n "$stashes" -a "$stashes" -ne 0
        set_color $material_yellow_500
        echo -n "⚑ $stashes"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$staged" -a "$staged" -ne 0
        set_color $material_green_A700
        echo -n " $staged"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$unmerged" -a "$unmerged" -ne 0
        set_color $material_red_300
        echo -n " $unmerged"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$dirty" -a "$dirty" -ne 0
        set_color $material_red_A200
        echo -n "󰄱 $dirty"
        set_color $material_grey_50
        echo -n ' '
    end

    if test -n "$untracked" -a "$untracked" -ne 0
        set_color $material_red_A100
        echo -n " $untracked"
        set_color $material_grey_50
        echo -n ' '
    end
end
