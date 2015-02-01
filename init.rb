# encoding: utf-8
require 'redmine'
require_dependency 'todos'
require_dependency 'todos_hooks'

Redmine::Plugin.register :redmine_wiki_todos do
  name        'Redmine Wiki Todos'
  author      'Grzegorz Rajchman'
  author_url  'https://github.com/mrliptontea'
  description 'Adds macro that allows you to embed a simple task list to Redmine\'s wiki'
  version     '0.0.1'

  Redmine::WikiFormatting::Macros.register do
    desc "Embed simple todo list\n" +
         "Usage:\n" +
         "<pre>{{todo\n" +
         "- [x] This is done\n" +
         "+ [ ] Incomplete\n" +
         "* [ ] Buy milk\n" +
         "}}</pre>\n\n" +
         "To make items clickable, simply add a parameter:\n" +
         "<pre>{{todo(clickable)\n" +
         "[ ] Click me\n" +
         "[ ] And me too!\n" +
         "}}</pre>\n\n" +
         "Note: unordered list indicators (*, +, -) are optional and nested lists (i.e. subitems) are not supported."
    macro :todo, :parse_args => true do |obj, args, text|
      clickable = args[0] == "clickable"
      todo      = WikiTodoList::TodoList.new(obj, text, clickable)
      list      = todo.parse
      content   = ''

      if list.length > 0
          list.each do |item|
            content << '<li class="task-list-item">'
            line = textilizable(item.text, :object => obj, :headings => false)

            if item.task?
              cb = '<input type="checkbox" class="task-list-item-checkbox"'
                cb << "#{'checked="checked"' if item.complete?}"
                cb << "#{'disabled="disabled"' unless clickable}"
              cb << '/> '
              content << line.sub(/<(p|h\d+)>/, '<label class="task-list-item-label">' + cb).sub(/<\/(p|h\d+)>/, '</label>')
            else
              content << line
            end

            content << "</li>\n"
          end
      end

      content_tag('ul', content.html_safe, :class => "task-list #{'task-list-clickable' if clickable}")
    end
  end
end
