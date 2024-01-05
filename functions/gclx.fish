function gclx --description="Git clone and cd"
    # Check if an argument is provided
    if test (count $argv) -ne 1
        echo "Usage: gclx owner/repo or gclx https://github.com/owner/repo.git"
        return 1
    end

    # Extract owner and repo names from the argument
    set owner (echo $argv[1] | sed 's|^https://github.com/\(.*\)/\(.*\)\.git$|\1|')
    set repo (echo $argv[1] | sed 's|^https://github.com/\(.*\)/\(.*\)\.git$|\2|')

    # If the argument is not a full URL, assume it's in owner/repo format
    if test "$owner" = "$argv[1]"
        set owner (echo $argv[1] | cut -d '/' -f 1)
        set repo (echo $argv[1] | cut -d '/' -f 2)
    end

    # Perform git clone
    if git clone "https://github.com/$owner/$repo.git" $repo
        # Change to the newly cloned directory
        cd $repo
    else
        echo "Error: Failed to clone repository."
        return 1
    end
end
