---
title: "Functions"
date: 2023-11-16T20:26:28+01:00
draft: false
---

Terraform has many built-in functions that can be used to transform and combine values. They can be used in expressions and interpolations.

## Numeric Functions

- `abs`: Returns the absolute value of a number.
- `floor`: Returns the largest integer value less than or equal to a number.
- `ceil`: Returns the smallest integer value greater than or equal to a number.
- `min`: Returns the smallest of one or more numbers.
- `max`: Returns the largest of one or more numbers.
- `log`: Returns the natural logarithm of a number.
- `pow`: Returns a number raised to a specified power.
- `signum`: Returns the sign of a number, indicating whether the number is positive, negative, or zero.
- `parseint`: Converts a string representation of a number into an integer given a specified base.

## String Functions

- `chomp`: Removes trailing newline characters from a string.
- `format`: Returns a formatted string from a format string and a list of values. Similar to `printf` in other languages.
- `formatlist`: Returns a formatted string from a format string and a list of values. Similar to `printf` in other languages.
- `indent`: Indents each line of a string by a given number of spaces.
- `join`: Joins a list of strings into a single string using a separator.
- `lower`: Returns a copy of a string with all Unicode letters mapped to their lower case.
- `regex`: Returns a the first substring matched by a regular expression.
- `regexall`: Returns all substrings matched by a regular expression as a list.
- `replace`: Returns a copy of a string with all occurrences of a substring replaced with a new substring.
- `split`: Returns a list of substrings, separated by a delimiter.
- `strrev`: Returns a reversed string.
- `substr`: Returns a substring of a string given a starting position and length.
- `title`: Returns a copy of a string with all Unicode letters that begin words mapped to their title case.
- `trim`: Returns a copy of a string with leading and trailing of the specified characters removed.
- `trimprefix`: Returns a copy of a string with the specified prefix removed. 
- `trimsuffix`: Returns a copy of a string with the specified suffix removed.
- `trimspace`: Returns a copy of a string with all leading and trailing white space removed, as defined by Unicode.
- `upper`: Returns a copy of a string with all Unicode letters mapped to their upper case.

## Collection Functions

- `alltrue`: Returns true if all the given values are true.
- `anytrue`: Returns true if any of the given values are true.
- `chunklist`: Returns a list of lists, each containing a subset of the given list of a given size.
- `coalesce`: Returns the first non-null value in a given list.
- `coalescelist`: Returns the first non-null value in a given list.
- `compact`: Returns a copy of a list with all null values removed.
- `concat`: Returns a new list by concatenating lists together.
- `contains`: Returns true if a given list contains a given value.
- `distinct`: Returns a copy of a list with all duplicate elements removed.
- `element`: Returns the element of a list at a given index.
- `index`: Returns the index of a given value in a list.
- `flatten`: Returns a copy of a list of lists, flattened to a single list.
- `keys`: Returns a list of all the keys in a map.
- `length`: Returns the length of a string, list, or map.
- `lookup`: Returns the value of a single element from a map, given its key. If the given key does not exist, a default value is returned.
- `matchkeys`: Returns a list of element whose indices match the corresponding indices in another list.
  - Example: `matchkeys(["a", "b", "c"], ["A", "B", "C"], ["A"])` returns `["a"]`.
- `merge`: Returns a map that is the result of merging two or more maps.
- `one`: Takes a list of zero or one element and returns the element if it exists, or null if the list is empty. If the list has more than one element, an error is thrown.
- `range`: Returns a list of numbers in a given range.
- `reverse`: Returns a copy of a list with elements in reverse order.
- `setintersection`: Returns a list that contains only the elements that exist in all of the given lists.
- `setproduct`: Returns a list of all possible combinations of elements from two or more given lists (Cartesian product).
- `setsubtract`: Returns a list that contains only the elements that exist in the first list but not in any of the other given lists.
- `setunion`: Returns a list that contains all of the elements of all of the given lists.
- `slice`: Returns a subset of a list, given a starting index and length.
- `sort`: Returns a copy of a list with elements in sorted order (always strings if input is number is casted)
- `sum`: Returns the sum of a list of numbers.
- `transpose`: Takes a map of string lists and returns another one with the keys and values swapped.
  - Example: `transpose({"a":["1","2"], "b": ["3", "4"], "c": ["1", "3"]})` returns `{"1":["a", "c"], "2":["a"], "3":["b", "c"], "4":["b"]}`.
- `values`: Returns a list of all the values in a map.
- `zipmap`: Returns a map by combining two lists into a map (Element in the first list is the key, element in the second list is the value).

## Encoding Functions

- `base64decode`: Returns a string decoded from a base64-encoded string.
- `base64encode`: Returns a string encoded to a base64-encoded string.
- `jsondecode`: Returns a map or list decoded from a JSON string.
- `jsonencode`: Returns a JSON string from a given map or list.
- `yamldecode`: Returns a map or list decoded from a YAML string.
- `yamlencode`: Returns a YAML string from a given map or list.
- `urlencode`: Returns a string encoded to a URL-encoded string.
- `base64gzip`: Returns a string encoded to a base64-encoded string and compressed with gzip.

## Filesystem Functions

- `abspath`: Returns the absolute path of a file.
- `dirname`: Returns the directory of a file path.
- `pathexpand`: Returns the path of a file with the user's home directory expanded.
- `basename`: Returns the file name of a file path.
- `file`: Returns the contents of a file as a string.
- `fileexists`: Returns true if a file exists.
- `fileset`: Returns a list of files for given glob patterns.
- `filebase64`: Returns the contents of a file as a base64-encoded string.
- `templatefile`: Returns a rendered template from a template file and a set of template variables.

## Date and Time Functions

- `formatdate`: Returns a formatted date string from a timestamp.
- `timeadd`: Returns a timestamp that is a given amount of time after a given timestamp.
- `timestamp`: Returns a timestamp from a date string. Can be used as input for other date and time functions.

## Hash and Crypto Functions

Functions that return a hashes and cryptographic strings

- `bcrypt`: Returns a bcrypt hash of a given string. Used for shadow password files.
- `uuid`: Returns a version 4 UUID.
- Others like base64sha256, base64sha512, md5, sha1, sha256, sha512, etc.

## IP Network Functions

- `cidrhost`: Returns the host address within a given CIDR range.
- `cidrnetmask`: Returns the network mask within a given CIDR range.
- `cidrsubnet`: Returns a subnet address within a given CIDR range.
- `cidrsubnets`: Returns a list of subnet addresses within a given CIDR range.


## Type Conversion Functions

- `can`: Returns true if no error is thrown when evaluating an expression.
- `default`: Returns a default value if an expression returns null.
- `nonsensitive`: Returns a non-sensitive value from a sensitive value.
- `sensitive`: Returns a sensitive value from a non-sensitive value.
- `tobool`: Returns a boolean value from a given value.
- `tomap`: Returns a map from a given value.
- `tonumber`: Returns a number from a given value.
- `toset`: Returns a set from a given value.
- `tostring`: Returns a string from a given value.
- `try` evaluates a list of expressions and returns the value of the first expression that does not throw an error.