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
        mkdir -p "$content_dir/$1"
        hugo new "$content_dir/$1/_index.md" -k index
        echo "Created $1 section."
    fi
}

# This function creates a new sub-section
function new_subsection {
    if [ -z $1 ] || [ -z $2 ]; then
        echo "No section or subsection name provided."
    else
        if [ ! -d "$content_dir/$1" ]; then
            echo "Section $1 does not exist, creating it now."
            new_section $1
        fi
        mkdir -p "$content_dir/$1/$2"
        hugo new "$content_dir/$1/$2/_index.md" -k index
        echo "Created $2 subsection in $1 section."
    fi
}

# This function creates a new article in a section or subsection
function new_article {
    # If 3 arguments are provided, the article is created in a subsection
    if [ "$#" -eq 3 ]; then
        section=$1
        subsection=$2
        article=$3
        if [ ! -d "$content_dir/$section" ]; then
            echo "Section $section does not exist, creating it now."
            new_section $section
        fi
        if [ ! -d "$content_dir/$section/$subsection" ]; then
            echo "Subsection $subsection does not exist in section $section , creating it now."
            new_subsection $section $subsection
        fi
        hugo new "$content_dir/$section/$subsection/$article.md"
        echo "Created $article article in $subsection subsection in $section section."
    elif [ "$#" -eq 2]; then
        section=$1
        article=$2
        if [ ! -d "$content_dir/$section" ]; then
            echo "Section $section does not exist, creating it now."
            new_section $section
        fi
        hugo new "$content_dir/$section/$article.md"
        echo "Created $article article in $section section."
    else
        echo "Error: Invalid number of arguments, either 2 or 3 arguments are required."
    fi

}

# This function displays the usage
function usage {
    echo "Usage: $0 <command> [args]"
    echo "Commands:"
    echo "  new_section <section_name>"
    echo "  new_subsection <section_name> <subsection_name>"
    echo "  new_article <section_name> <article_name>| <section_name> <subsection_name> <article_name>"
}

# This is the main function
function main {
    if [ -z $1 ]; then
        usage
    else
        case "$1" in
        section)
            new_section $2
            ;;
        subsection)
            new_subsection $2 $3
            ;;
        article)
            new_article $2 $3 $4
            ;;
        *)
            usage
            ;;
        esac
    fi
}

# Call the main function
main $1 $2 $3 $4
