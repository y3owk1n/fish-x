function gclx --description="Git clone and cd"
    # Check if an argument is provided
    if test (count $argv) -ne 1
        echo "Usage: gclx owner/repo or gclx https://github.com/owner/repo.git"
        return 1
    end

    set is_bare_repo false

    # Check for the --bare option
    if test "$argv[1]" = --bare
        set is_bare_repo true
        set argv[1] # Remove the --bare option from the arguments
    end

    # Extract owner and repo names from the argument
    set url_or_owner_repo $argv[1]
    set owner
    set repo

    if string match --regex --start '^https://github.com/(.*)\.git$' $url_or_owner_repo
        # Extract owner and repo from URL
        set owner $match[1]
        set repo (basename $url_or_owner_repo .git)
        elif string match --regex --start '^([^/]+)/([^/]+)$' $url_or_owner_repo
        # Extract owner and repo from owner/repo format
        set owner $match[1]
        set repo $match[2]
    else
        echo "Error: Invalid input format. Please use owner/repo or https://github.com/owner/repo.git"
        return 1
    end

    # Perform git clone
    if $is_bare_repo
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
