function gclx --description="Git clone and cd"
    # Check if an argument is provided
    if test (count $argv) -eq 0
        echo "Usage: gclx owner/repo or gclx https://github.com/owner/repo.git"
        return 1
    end

    set -l is_bare_repo false

    echo "argv: $argv"

    # Check for the --bare option
    if test "$argv[1]" = --bare
        set is_bare_repo true
        set argv[1] $argv[2] # Remove the --bare option from the arguments
    end

    # Extract owner and repo names from the argument
    set owner (echo $argv[1] | sed 's|^https://github.com/\(.*\)/\(.*\)\.git$|\1|')
    set repo (echo $argv[1] | sed 's|^https://github.com/\(.*\)/\(.*\)\.git$|\2|')

    if test "$owner" = "$argv[1]"
        set owner (echo $argv[1] | cut -d '/' -f 1)
        set repo (echo $argv[1] | cut -d '/' -f 2)
    end

    echo "owner: $owner"
    echo "repo: $repo"
    echo "is_bare_repo: $is_bare_repo"

    # Perform git clone
    if test $is_bare_repo -eq true
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
