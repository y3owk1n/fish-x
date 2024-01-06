function gclx --description="Git clone and cd"
    # Check if an argument is provided
    if test (count $argv) -ne 1
        echo "Usage: gclx owner/repo or gclx https://github.com/owner/repo.git"
        return 1
    end

    set -l is_bare_repo false

    echo "argv: $argv"
    if test (count $argv) -gt 0
        for i in (seq (count $argv))
            if test "$argv[$i]" = --bare
                set is_bare_repo true
            else
                # Check if there is another argument after the current one
                if test (count $argv) -ge (math $i + 1)
                    # Extract owner and repo names from the argument
                    set owner (echo $argv[(math $i + 1)] | sed 's|^https://github.com/\(.*\)/\(.*\)\.git$|\1|')
                    set repo (echo $argv[(math $i + 1)] | sed 's|^https://github.com/\(.*\)/\(.*\)\.git$|\2|')

                    # If the argument is not a full URL, assume it's in owner/repo format
                    if test "$owner" = "$argv[(math $i + 1)]"
                        set owner (echo $argv[(math $i + 1)] | cut -d '/' -f 1)
                        set repo (echo $argv[math $i + 1] | cut -d '/' -f 2)
                    end
                end
            end
        end
    end

    echo "owner: $owner"
    echo "repo: $repo"
    echo "is_bare_repo: $is_bare_repo"

    # Perform git clone
    if test $is_bare_repo
        git clone --bare "https://github.com/$owner/$repo.git" $repo
    else
        git clone "https://github.com/$owner/$repo.git" $repo
    end

    # Check if git clone was successful
    if test $status -eq 0
        # Change to the newly cloned directory
        cd $repo
    else
        echo "Error: Failed to clone repository."
        return 1
    end
end
