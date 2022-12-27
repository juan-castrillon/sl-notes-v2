#! /bin/bash
# This script is used to create content in the content directory
# It accepts the following subcommands:
#   new_section <section_name> - creates a new section
#   new_article <section_name> <article_name> - creates a new article

content_dir="./content"

# This function creates a new section
function new_section {
    if [ -z $1 ]; then
        echo "No section name provided."
    else
        mkdir -p "$content_dir/docs/$1"
        hugo new "$content_dir/docs/$1/_index.md" -k index
        echo "Created $1 section."
    fi
}

# This function creates a new article
function new_article {
    if [ -z $1 ] || [ -z $2 ]; then
        echo "No section or article name provided."
    else
        if [ ! -d "$content_dir/docs/$1" ]; then
            echo "Section $1 does not exist."
        else
            hugo new "$content_dir/docs/$1/$2.md"
            echo "Created $2 article in $1 section."
        fi
    fi
}

# This function displays the usage
function usage {
    echo "Usage: $0 <command> [args]"
    echo "Commands:"
    echo "  new_section <section_name>"
    echo "  new_article <section_name> <article_name>"
}

# This is the main function
function main {
    if [ -z $1 ]; then
        usage
    else
        case "$1" in
        new_section)
            new_section $2
            ;;
        new_article)
            new_article $2 $3
            ;;
        *)
            usage
            ;;
        esac
    fi
}

# Call the main function
main $1 $2 $3
