return {
  -- Auto-close brackets, quotes, and parenthesis
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true, -- Automatically runs the setup function
  }
}
