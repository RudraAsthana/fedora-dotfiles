return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- Use Papers (Fedora's new default document viewer)
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "papers"
      
      -- Do not hijack the screen for minor warnings
      vim.g.vimtex_quickfix_open_on_warning = 0

      -- Force latexmk to use XeLaTeX globally
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-xelatex",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end
  }
}
