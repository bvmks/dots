M = {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },

    event = "VeryLazy",

    config = function()
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = false

        local ufo = require("ufo")
        ufo.setup()

        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
    end,
}

-- return M
return {}

