return {
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        name = "cyberdream",
        priority = 1000,

        config = function()
            require("cyberdream").setup({
                transparent = true,
                italic_comments = true,
                borderless_telescope = false
            })
            vim.cmd.colorscheme("cyberdream")
        end,
    },
    {
        "LazyVim/LazyVim",
        config = function()
            vim.cmd.colorscheme("cyberdream")
        end,
    },
    {
        "mawkler/modicator.nvim",
        dependencies = "scottmckendry/cyberdream.nvim",
        init = function()
            vim.o.cursorline = false
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },
}
