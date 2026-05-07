return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },

    event = "BufReadPost",

    opts = {
        provider_selector = function(_, filetype, _)
            -- по умолчанию markdown и git не фолдуют treesitter'ом
            if filetype == "markdown" or filetype == "git" then
                return { "indent" }
            end
            return { "treesitter", "indent" }
        end
    },

    config = function(_, opts)
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require("ufo").setup(opts)

        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
}

