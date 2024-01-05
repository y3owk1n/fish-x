function gclx --description="Git clone and cd"
    # Check if an argument is provided
    if test (count $argv) -ne 1
        echo "Usage: gclx owner/repo or gclx https://github.com/owner/repo.git"
        return 1
    end

    set repo_url $argv[1]

    # Extract owner and repo names from the argument
    set owner (string match -r '^https://github.com/([^/]+)/([^/]+)\.git$' $repo_url --capture=1)
    set repo (string match -r '^https://github.com/([^/]+)/([^/]+)\.git$' $repo_url --capture=2)

    # If the argument is not a full URL, assume it's in owner/repo format
    if test "$owner" = "$repo_url"
        set owner (string split '/' $repo_url)[1]
        set repo (string split '/' $repo_url)[2]
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
