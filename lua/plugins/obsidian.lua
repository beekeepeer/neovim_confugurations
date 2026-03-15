return {
  "obsidian-nvim/obsidian.nvim",
  -- This part registers the group name in WhichKey
  init = function()
    require("which-key").add({
      { "<leader>o", group = "Obsidian", icon = "󱓧 " },
    })
  end,
  version = "*", 
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, 
    workspaces = {
      {
        name = "ObsidianVault",
        path = "~/Documents/ObsidianVault/",
      },
    },
    templates = {
      subdir = "Templates", 
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },


  -- 2. Configure how new notes are initialized
  -- If this is set to nil or an empty string, it won't insert any header/YAML.
  note_id_func = function(title)
    return title or tostring(os.time())
  end,


    ui = {
    enable = true, -- Keep UI features but...
    update_debounce = 200,
  },

  -- You might also want to ensure the alias matches the title exactly
  ---@param spec { id: string, title: string|?, alias: string[]|? }
  ---@return string|table
  note_path_func = function(spec)
    -- This ensures the file is saved as "My Note Name.md" 
    -- instead of "my-note-name.md"
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md")
  end,

    ---@param note obsidian.Note
frontmatter = {
    enable = false,
  ---@param note obsidian.Note
  func = function(note)
    -- 1. Start with EVERYTHING already in the note's frontmatter
    local out = {}
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    -- 2. Add or overwrite your specific fields
    -- This keeps existing aliases/tags if they exist, 
    -- or creates them from the note object if they are new.
    out.aliases = note.aliases
    out.tags = note.tags
    
    -- 3. Set your custom fields
    out.date = os.date("%Y-%m-%d")
-- ONLY set "my" if source is currently nil or empty
        if out.source == nil or out.source == "" then
          out.source = "my"
        end
    return out
  end,
},  },
  keys = {
    -- Top Level / Navigation
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search Notes" },
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show Backlinks" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Search Tags" },
    { "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Switch Workspace" },

    -- Daily Notes
    { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Daily Notes List" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday's Note" },
    { "<leader>oj", "<cmd>Obsidian today<cr>", desc = "Today's Note" },
    { "<leader>ok", "<cmd>Obsidian tomorrow<cr>", desc = "Tomorrow's Note" },

    -- Note Actions
    { "<leader>of", "<cmd>Obsidian follow_link<cr>", desc = "Follow Link" },
    { "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle Checkbox" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "List All Links" },
    { "<leader>oi", "<cmd>Obsidian paste_img<cr>", desc = "Paste Image" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename Note" },
    { "<leader>oT", "<cmd>Obsidian toc<cr>", desc = "Table of Contents" },

    -- Templates & Help
    { "<leader>om", "<cmd>Obsidian template<cr>", desc = "Insert Template" },
    { "<leader>oN", "<cmd>Obsidian new_from_template<cr>", desc = "New Note from Template" },
    { "<leader>o?", "<cmd>Obsidian help<cr>", desc = "Obsidian Help" },
    { "<leader>og", "<cmd>Obsidian helpgrep<cr>", desc = "Grep Help" },

    -- Integration
    { "<leader>op", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian App" },

    -- Visual Mode Commands-- Highlight Selection
    { 
      "<leader>oh", 
      ":s/\\%V.*\\%V./==&==/<cr><cmd>noh<cr>", 
      mode = "v", 
      desc = "Highlight Selection (==)" 
    },
    { 
      "<leader>oq", 
      ":s/\\%V.*\\%V./[[|&]]/<cr><cmd>noh<cr>F|i", 
      mode = "v", 
      desc = "Link Selection as Alias" 
    },
    { 
      "<leader>oq", 
      ":Obsidian link new<cr>", 
      mode = "v", 
      desc = "Link Selection to New Note" 
    },
    { "<leader>on", ":Obsidian extract_note<cr>", mode = "v", desc = "Extract to New Note" },
    { "<leader>ol", ":Obsidian link<cr>", mode = "v", desc = "Link Selection" },
    { "<leader>oL", ":Obsidian link_new<cr>", mode = "v", desc = "Link to New Note" },
  },
}
