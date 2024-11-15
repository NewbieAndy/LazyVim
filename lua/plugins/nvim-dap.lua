return {

  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dv", function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" },
    },
  },
}
