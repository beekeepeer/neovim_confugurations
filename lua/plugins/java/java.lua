-- ~/.config/nvim/lua/plugins/java.lua

-- This file tells LazyVim to load the nvim-jdtls plugin for Java files,
-- and configures only the JDK 24 runtime on Windows while keeping all other
-- defaults intact.

return {
  {
    -- Java Language Server
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")
      local setup = require("jdtls.setup")

      -- Find project root using the same markers LazyVim uses
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
      local root_dir = setup.find_root(root_markers)
      if not root_dir then
        return
      end

      -- Start or attach to the language server, overriding only the JDK-24 path
jdtls.start_or_attach({
  cmd = { "jdtls" },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-24",
            path = "C:\\Program Files\\Java\\jdk-24",
          },
        },
      },
      format = {
        settings = {
          url     = "C:\\Users\\goriu\\AppData\\Local\\vim\\lua\\plugins\\java\\Default.xml",
          profile = "Default",
        },
      },
    },
  },
})
    end,
  },
}
