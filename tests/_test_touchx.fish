set temp_dir (mktemp -d)

# Function to delete files
function cleanup_files
    for file in file1.txt file2.txt file3.txt
        if test -f $file
            rm -f $file
        end
    end
end

# Mock nvim
function nvim
    echo "nvim executed"
    return 1
end

# Mock the EDITOR variable
set -U EDITOR nvim

# Test touchx displays usage message when no arguments provided
cd $temp_dir
touchx >/dev/null

@test "exit status is non-zero" $status -ne 0

@test "error message is displayed" (touchx) = "Usage: touchx <file>"

# Clean up
cd $temp_dir
cleanup_files

# Test touchx touches a file and echoes a message
touchx file1.txt

@test "file is created" -e file1.txt

# Check if the editor function run properly
@test "opened with editor message" (touchx file1.txt) = "nvim executed"

# Clean up
cd $temp_dir
cleanup_files

# Test touchx handles unset EDITOR
set -e EDITOR
touchx file2.txt >/dev/null

@test "exit status is non-zero for unset EDITOR" $status -ne 0

# Clean up
cd $temp_dir
cleanup_files

# Test touchx handles non-executable editor
set -U EDITOR invalid-editor
touchx file3.txt >/dev/null

@test "exit status is non-zero for non-executable editor" $status -ne 0

# Clean up
cd $temp_dir
cleanup_files

rm -rf $temp_dir
