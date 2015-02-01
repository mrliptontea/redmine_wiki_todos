# Redmine wiki task lists

Adds macro that allows you to embed a simple task list with clickable checkboxes to Redmine's wiki

## Installation

Just put `redmine_wiki_todos` folder into your Redmine's `plugins` folder and restart Redmine.

## Usage

Add something like this to your wiki page or issue description:

    {{todo
    - [x] This is done
    + [ ] Incomplete
    * [ ] Buy milk
    }}

A line of the text is considered a task if it contains square braces with a space between them at the beginning. Completed tasks can be marked with letter x (upper- or lower-case).

To make items clickable, simply add a parameter:

    {{todo(clickable)
    [ ] Click me
    [ ] And me too!
    }}

Note: unordered list indicators are optional and nested lists are not supported.

## License

[WTFPL](http://www.wtfpl.net/)
