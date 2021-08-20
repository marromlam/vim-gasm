-- 
--   ,dPYb,                                                                
--   IP'`Yb                                                                
--   I8  8I                                         gg                     
--   I8  8'                                         ""                     
--   I8 dP  gg      gg    ,gggg,gg     ggg    gg    gg    ,ggg,,ggg,,ggg,  
--   I8dP   I8      8I   dP"  "Y8I    d8"Yb   88bg  88   ,8" "8P" "8P" "8, 
--   I8P    I8,    ,8I  i8'    ,8I   dP  I8   8I    88   I8   8I   8I   8I 
--  ,d8b,_ ,d8b,  ,d8b,,d8,   ,d8b,,dP   I8, ,8I  _,88,_,dP   8I   8I   Yb,
--  8P'"Y888P'"Y88P"`Y8P"Y8888P"`Y88"     "Y8P"   8P""Y88P'   8I   8I   `Y8
--  
--  This is the main configuration file for the lua-based nvim configuration.
--  The main configuration flags can be controlled here, such as themes and 
--  the compulsory-to-be-loaded packages. All the rest of packages are lazy
--  loaded upon user request.
--
--  Marcos Romero Lamas (marromlam@gmail.com)
--  Created on Aug 20 of 2021


-- Set appearance
vim.g.colorscheme = "material"
vim.g.colors_style = "oceanic"
vim.g.colors_lighter_contrast = false
vim.g.nvchad_theme = "onedark"


-- Set binaries
-- These are basically to tell vim where to find providers
vim.g.python3_host_prog = vim.fn.expand(os.getenv "HOMEBREW" .. "/bin/python3.9")
vim.g.pydocstring_doq_path = os.getenv "HOMEBREW" .. "/bin/doq"


-- Since we won't load Packer at startup
vim.cmd "silent! command PackerCompile lua require 'packer_list' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'packer_list' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'packer_list' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'packer_list' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'packer_list' require('packer').update()"


-- Load only stricly needed config
require "general.settings"
require "keys.mappings".config()
