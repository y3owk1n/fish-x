set temp_dir (mktemp -d)

# Function to delete directories
function cleanup_directories
    for dir in dir1 dir2 dir3
        if test -d $dir
            rm -rf $dir
        end
    end
end

# Test mkdirx displays usage message when no arguments provided
cd $temp_dir
mkdirx >/dev/null

@test "exit status is non-zero" $status -ne 0

@test "error message is displayed" (mkdirx) = "Usage: mkdirx folder"

cd $temp_dir
cleanup_directories

# Test mkdirx creates and changes to the directory
mkdirx dir1

@test "current directory is the created directory" (pwd) = "$temp_dir/dir1"

cd $temp_dir
cleanup_directories

# Test mkdirx changes to an existing directory
cd $temp_dir
mkdir -p dir_existing
cd dir_existing
set initial_dir (pwd)
echo $initial_dir

# Run mkdirx multiple times to ensure only one existing directory is created
cd $temp_dir
mkdirx dir_existing
cd $temp_dir
mkdirx dir_existing
cd $temp_dir
mkdirx dir_existing

# Check that the current directory remains the same
@test "current directory is unchanged" (pwd) = $initial_dir

cd $temp_dir

# Confirm only one directory is created
@test "only one directory is created" (count (ls)) -eq 1

# Clean up
cd $temp_dir
cleanup_directories

rm -rf $temp_dir
