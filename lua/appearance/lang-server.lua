local LSP = {
  LspDiagnosticsDefaultError = { fg = C.error },
  LspDiagnosticsDefaultWarning = { fg = C.warning },
  LspDiagnosticsDefaultInformation = { fg = C.info_yellow },
  LspDiagnosticsDefaultHint = { fg = C.hint_blue },
  LspDiagnosticsVirtualTextError = { fg = C.error },
  LspDiagnosticsVirtualTextWarning = { fg = C.warning },
  LspDiagnosticsVirtualTextInformation = { fg = C.info_yellow },
  LspDiagnosticsVirtualTextHint = { fg = C.hint_blue },
  LspDiagnosticsFloatingError = { fg = C.error },
  LspDiagnosticsFloatingWarning = { fg = C.warning },
  LspDiagnosticsFloatingInformation = { fg = C.info_yellow },
  LspDiagnosticsFloatingHint = { fg = C.hint_blue },
  LspDiagnosticsSignError = { fg = C.error },
  LspDiagnosticsSignWarning = { fg = C.warning },
  LspDiagnosticsSignInformation = { fg = C.info_yellow },
  LspDiagnosticsSignHint = { fg = C.hint_blue },
  LspDiagnosticsError = { fg = C.error },
  LspDiagnosticsWarning = { fg = C.warning },
  LspDiagnosticsInformation = { fg = C.info_yellow },
  LspDiagnosticsHint = { fg = C.hint_blue },
  LspDiagnosticsUnderlineError = { style = "underline" },
  LspDiagnosticsUnderlineWarning = { style = "underline" },
  LspDiagnosticsUnderlineInformation = { style = "underline" },
  LspDiagnosticsUnderlineHint = { style = "underline" },
  QuickScopePrimary = { fg = C.purple_test, style = "underline" },
  QuickScopeSecondary = { fg = C.cyan_test, style = "underline" },
  TelescopeSelection = { fg = C.hint_blue },
  TelescopeMatching = { fg = C.info_yellow, style = "bold" },
  TelescopeBorder = { fg = C.cyan, bg = Config.transparent_background and "NONE" or C.bg },
  NvimTreeFolderIcon = { fg = C.blue },
  NvimTreeIndentMarker = { fg = C.gray },
  NvimTreeNormal = { fg = C.light_gray, bg = C.bg_alt },
  NvimTreeVertSplit = { fg = C.line_bg, bg = C.bg_alt },
  NvimTreeFolderName = { fg = C.blue },
  NvimTreeOpenedFolderName = { fg = C.cyan, style = "italic" },
  NvimTreeImageFile = { fg = C.purple },
  NvimTreeSpecialFile = { fg = C.orange },
  NvimTreeGitStaged = { fg = C.sign_add },
  NvimTreeGitNew = { fg = C.sign_add },
  NvimTreeGitDirty = { fg = C.sign_add },
  NvimTreeGitDeleted = { fg = C.sign_delete },
  NvimTreeGitMerge = { fg = C.sign_change },
  NvimTreeGitRenamed = { fg = C.sign_change },
  NvimTreeSymlink = { fg = C.cyan },
  NvimTreeRootFolder = { fg = C.fg, style = "bold" },
  NvimTreeExecFile = { fg = C.green },
  LirFloatNormal = { fg = C.light_gray, bg = C.bg_alt },
  LirDir = { fg = C.blue },
  LirSymLink = { fg = C.cyan },
  LirEmptyDirText = { fg = C.blue },
  BufferCurrent = { fg = C.fg, bg = C.bg },
  BufferCurrentIndex = { fg = C.fg, bg = C.bg },
  BufferCurrentMod = { fg = C.info_yellow, bg = C.bg },
  BufferCurrentSign = { fg = C.hint_blue, bg = C.bg },
  BufferCurrentTarget = { fg = C.red, bg = C.bg, style = "bold" },
  BufferVisible = { fg = C.fg, bg = C.bg_alt },
  BufferVisibleIndex = { fg = C.fg, bg = C.bg },
  BufferVisibleMod = { fg = C.info_yellow, bg = C.bg },
  BufferVisibleSign = { fg = C.gray, bg = C.bg },
  BufferVisibleTarget = { fg = C.red, bg = C.bg, style = "bold" },
  BufferInactive = { fg = C.gray, bg = C.line_bg },
  BufferInactiveIndex = { fg = C.gray, bg = C.line_bg },
  BufferInactiveMod = { fg = C.info_yellow, bg = C.line_bg },
  BufferInactiveSign = { fg = C.gray, bg = C.line_bg },
  BufferInactiveTarget = { fg = C.red, bg = C.line_bg, style = "bold" },
  StatusLine = { fg = C.bg_alt },
  StatusLineNC = { fg = C.bg_alt },
  StatusLineSeparator = { fg = C.bg_alt },
  StatusLineTerm = { fg = C.bg_alt },
  StatusLineTermNC = { fg = C.bg_alt },
  CodiVirtualText = { fg = C.hint_blue },
  IndentBlanklineContextChar = { fg = C.accent },
  DashboardHeader = { fg = C.blue },
  DashboardCenter = { fg = C.purple },
  DashboardFooter = { fg = C.cyan },
  xmlTag = { fg = C.cyan },
  xmlTagName = { fg = C.cyan },
  xmlEndTag = { fg = C.cyan },
  CompeDocumentation = { bg = C.bg_alt },
  DiffViewNormal = { fg = C.gray, bg = C.bg_alt },
  DiffviewStatusAdded = { fg = C.sign_add },
  DiffviewStatusModified = { fg = C.sign_change },
  DiffviewStatusRenamed = { fg = C.sign_change },
  DiffviewStatusDeleted = { fg = C.sign_delete },
  DiffviewFilePanelInsertion = { fg = C.sign_add },
  DiffviewFilePanelDeletion = { fg = C.sign_delete },
  DiffviewVertSplit = { bg = C.bg },
  diffAdded = { fg = C.sign_add },
  diffRemoved = { fg = C.sign_delete },
  diffFileId = { fg = C.blue, style = "bold,reverse" },
  diffFile = { fg = C.bg_alt },
  diffNewFile = { fg = C.green },
  diffOldFile = { fg = C.red },
  debugPc = { bg = C.cyan },
  debugBreakpoint = { fg = C.red, style = "reverse" },
}

return LSP
