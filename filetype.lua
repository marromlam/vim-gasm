if not vim.filetype then
  return
end

vim.filetype.add({
  extension = {
    lock = "yaml",
  },
  filename = {
    ["NEOGIT_COMMIT_EDITMSG"] = "NeogitCommitMessage",
    [".psqlrc"] = "conf",
    ["launch.json"] = "jsonc",
    Podfile = "ruby",
    Brewfile = "ruby",
    Snakefile = "snakemake",
  },
  pattern = {
    [".*%.conf"] = "conf",
    [".*%.theme"] = "conf",
    [".*%.gradle"] = "groovy",
    ["^.env%..*"] = "bash",
  },
})
