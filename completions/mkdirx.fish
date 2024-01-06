complete mkdirx --no-files

function __mkdirx_folder_complete
    set -l options
    for option in (fd -t d -d 1)
        set options $options (basename $option)
    end
    echo $options
end

complete -c mkdirx -n __fish_use_subcommand -s d -l directory -a "(__mkdirx_folder_complete)" -d "Directory name"
