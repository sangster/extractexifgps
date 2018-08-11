# ExtractExifGps

[![Gem Version](https://badge.fury.io/rb/extractexifgps.svg)](https://badge.fury.io/rb/extractexifgps)
[![Maintainability](https://api.codeclimate.com/v1/badges/e5ff3fe936709bf32593/maintainability)](https://codeclimate.com/github/sangster/extractexifgps/maintainability)
[![GitHub license](https://img.shields.io/github/license/sangster/extractexifgps.svg)](https://github.com/sangster/extractexifgps/blob/master/LICENSE.txt)


`extractexifgps` is an application to extract EXIF GPS data from all the images
in a given directory.

## Installation

```sh
gem install extractexifgps
```

## Example Usage

```sh
extractexifgps > images_in_current_directory.csv
extractexifgps /some/directory/ > images_in_some_directory.csv

# CSV format
extractexifgps csv ./
extractexifgps -C ./ # short alias
extractexifgps csv -r ./ # file images recursively
extractexifgps csv -o /path/to/output.csv ./ # write directly to a file

# HTML format
extractexifgps html ./
extractexifgps -H ./ # short alias
extractexifgps html -r ./ # file images recursively
extractexifgps html -o /path/to/output.html ./ # write directly to a file
extractexifgps html -t /path/to/template.erb ./ # use a custom ERB template
```

### HTML Templates

`extractexifgps` comes with a default template to generate a decent-looking
HTML table, but you can supply your own
[ERB](https://ruby-doc.org/stdlib-2.5.1/libdoc/erb/rdoc/ERB.html) template to
generate any kind of HTML file you like. See the built-in
[templates/basic.html.erb](templates/basic.html.erb) as an example template.


### Command-line Help

You can get information about the command-line interface in general, or for
specific commands:

```sh
extractexifgps help
extractexifgps help csv
extractexifgps help html
```

## Development

### Testing

A few Rake commands will help your testing:

  - `rake test`: Run the test suite
  - `rake lint`: Run the code linters
  - `rake simplecov`: Run the code coverage reporter
  - `rake`: Run all tests, linters, and code coverage reporters

To facilitate development, consider running `guard` in the background while you
work. Whenver a source file it changed, it will automatically run the relevent
tests. This will provide you immediate test feedback at all times.

### Documentation

Generate code docs with:

```sh
rake doc
```

### Contributing to ExtractExifGps

  * Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
  * Check out the issue tracker to make sure someone already hasn't requested
    it and/or contributed it.
  * Fork the project.
  * Start a feature/bugfix branch.
  * Commit and push until you are happy with your contribution.
  * Make sure to add tests for it. This is important so I don't break it in a
    future version unintentionally.
  * Please try not to mess with the Rakefile, version, or history. If you want
    to have your own version, or is otherwise necessary, that is fine, but
    please isolate to its own commit so I can cherry-pick around it.
