# encoding: utf-8

module WikiTodoList
  class TodoList
    def initialize(obj, text, clickable = false)
      text       = "" if text.nil?
      @obj       = obj
      @text      = text.strip
      @clickable = clickable
    end

    def parse
      list = []
      first = true

      @text.each_line do |line|
        item = TodoListItem.new(line)

        if item.task? or first
          first = false
          list.push(item)
        else
          list.last.text << item.text
        end
      end

      list
    end
  end

  class TodoListItem
    attr_reader :checkbox, :text

    IncompletePattern = /\[[[:space:]]\]/.freeze # matches all whitespace
    CompletePattern   = /\[[xX]\]/.freeze        # matches any capitalization

    # Pattern used to identify all task list items.
    ItemPattern = /
      ^
      (?:\s*[-+*]|(?:\d+\.))? # optional list prefix
      \s*                     # optional whitespace prefix
      (?<checkbox>            # checkbox
        #{CompletePattern}|
        #{IncompletePattern}
      )
      \s*                     # followed by whitespace
      (?<text>.*)             # actual task description
    /x

    def initialize(line)
      item = line.match(ItemPattern)

      if item
        @checkbox = item[:checkbox]
        @text     = item[:text]
      else
        @checkbox = false
        @text     = line
      end
    end

    def task?
      @checkbox != false
    end

    def complete?
      !! (@checkbox =~ CompletePattern)
    end
  end
end
