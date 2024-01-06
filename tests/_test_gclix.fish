set temp_dir (mktemp -d)

set valid_owner y3owk1n
set valid_repo fish-x
set valid_url 'https://github.com/y3owk1n/fish-x.git'
set invalid_owner invalid-user
set invalid_repo invalid-repo
set invalid_url 'https://github.com/invalid-user/invalid-repo.git'

# Function to delete cloned repositories
function cleanup_repositories
    for repo in $valid_repo $invalid_repo
        if test -d $repo
            rm -rf $repo
        end
    end
end

# Test gclx displays usage message when no arguments provided
cd $temp_dir
gclx >/dev/null

@test "exit status is non-zero" $status -ne 0

@test "error message is displayed" (gclx) = "Usage: gclx owner/repo or gclx https://github.com/owner/repo.git"

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx with a valid repository URL
gclx $valid_url

@test "current directory is the repository directory" (pwd) = "$temp_dir/$valid_repo"

@test ".git folder exists" -d "$temp_dir/$valid_repo/.git"

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx with owner/repo format
gclx $valid_owner/$valid_repo

@test "current directory is the repository directory" (pwd) = "$temp_dir/$valid_repo"

@test ".git folder exists" (test -d .git) -eq 1

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx clones a bare repository
gclx --bare $valid_owner/$valid_repo

@test "current bare directory is the repository directory" (pwd) = "$temp_dir/$valid_repo"

@test "worktrees folder exists" (test -d worktrees) -eq 1

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx with an invalid repository URL
gclx $invalid_url >/dev/null

@test "exit status is non-zero for invalid repository URL" $status -ne 0

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx with an invalid owner/repo format
gclx $invalid_owner/$invalid_repo >/dev/null

@test "exit status is non-zero for invalid owner/repo format" $status -ne 0

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx handles cloning failure
gclx 'https://github.com/nonexistentuser/nonexistentrepo.git' >/dev/null

@test "exit status is non-zero for cloning failure" $status -ne 0

# Clean up
cd $temp_dir
cleanup_repositories

# Test gclx handles an invalid git clone command
function git
    echo "Mock git command"
    return 1
end

gclx $valid_url >/dev/null

@test "exit status is non-zero for invalid git clone command" $status -ne 0

# Clean up
cd $temp_dir
cleanup_repositories

rm -rf $temp_dir
