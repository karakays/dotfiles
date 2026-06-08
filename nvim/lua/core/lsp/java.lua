local M = {}

local jdtls_java_home = vim.fn.expand(os.getenv("JDTLS_JAVA_HOME") or "~/.sdkman/candidates/java/25.0.1-amzn")
local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar")

local function workspace_dir(root_dir)
  local project_root = vim.fs.normalize(root_dir or vim.fn.getcwd())
  local project_name = vim.fn.fnamemodify(project_root, ":t")
  local safe_project_name = project_name:gsub("[^%w_.-]", "_")
  local project_hash = vim.fn.sha256(project_root):sub(1, 8)
  local dir = string.format("%s/jdtls/workspaces/%s-%s", vim.fn.expand("~/.cache"), safe_project_name, project_hash)

  vim.fn.mkdir(dir, "p")
  return dir
end

function M.setup(lspconfig, capabilities)
  lspconfig.jdtls.setup({
    capabilities = capabilities,
    cmd_env = {
      JAVA_HOME = jdtls_java_home,
      PATH = jdtls_java_home .. "/bin:" .. (os.getenv("PATH") or ""),
    },
    on_new_config = function(new_config, root_dir)
      local workspace = workspace_dir(root_dir)

      for index, value in ipairs(new_config.cmd or {}) do
        if value == "-data" then
          new_config.cmd[index + 1] = workspace
          break
        end
      end

      new_config.init_options = vim.tbl_deep_extend("force", new_config.init_options or {}, {
        workspace = workspace,
      })

      if vim.fn.filereadable(lombok_jar) == 1 then
        table.insert(new_config.cmd, "--jvm-arg=-javaagent:" .. lombok_jar)
      end
    end,
    settings = {
      java = {
        eclipse = { downloadSources = true },
        maven = { downloadSources = true },
        configuration = {
          updateBuildConfiguration = "automatic",
          runtimes = {
            { name = "JavaSE-1.8", path = vim.fn.expand("~/.sdkman/candidates/java/8.0.452-amzn") },
            { name = "JavaSE-21", path = vim.fn.expand("~/.sdkman/candidates/java/21.0.7-amzn") },
            { name = "JavaSE-25", path = vim.fn.expand("~/.sdkman/candidates/java/25.0.1-amzn"), default = true },
          },
        },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*",
            "org.mockito.Mockito.*",
            "org.mockito.ArgumentMatchers.*",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
    },
  })
end

return M
