require 'redmine'

class WikiTodoListApplicationHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = {})
    return stylesheet_link_tag("wiki_todos.css", :plugin => "redmine_wiki_todos", :media => "all")
  end
end
