nvim
====

This is my neovim config.

It is a bit unexpected to have README.md here since it is mostly just my taste
on how editing should work, and I think everyone should choose their taste one
way or the other.

If you like my taste though, or just being curious, I hope this may sparkle
some ideas on your own setup.

### [options.lua](lua/config/options.lua)

* I absolutely need line numbers `vim.opt.number = true`.
* I absolutely need a ruler at column 80 `vim.opt.colorcolumn = 80`. I try to
  keep each line at 80 characters whenever I can.
* I absolutely need a highlight on my current line `vim.opt.cursorline = true`.
  This tells where I am currently at - otherwise finding where my cursor is can
  be annoy.

### [keymaps.lua](lua/config/keymaps.lua)

I often times need to copy from or paste to system clipboard, aka the `+`
register, so I absolutely need to have an easy way for that. My preference is to
leverage `<leader>` key - which is `<space>` for me.

`<leader>y`: copy into system clipboard
`<leader>p`: paste from system clipboard (after current cursor)
`<leader>P`: paste from system clipboard (before current cursor)

Something that was annoy to me is all deletions go to the unnamed register so
if I copied something, but then deleted something, I can't just use `p` since
the unnamed register had my deletions. My solution is to `<leader>0` because
deletions only override the unnamed register, but register `0` has my actual
yanked texts.

Pressing `j` and `k` to nativate a file can be toily and while `<C-d>` (down)
and `<C-u>` (up) can scroll half page up and down, when it comes close but not
too close - I often wanted a faster move ups and downs, so that's why I mapped
`<leader>j` and `<leader>k` to move 5 lines on each press. I find this useful.

Dealing with path is often necessary - like when I want to paste a path to
Codex or open a file in Github (and I have `@p` in Chrome to open a path in
monorepo directly), that's why I added:

`<leader>cr`: copy relative path
`<leader>cp`: copy full path (I rarely use this)
`<leader>cd`: copy relative path to directory only (I rarely use this)

### [fzf.lua](lua/config/fzf.lua)

There are really basically two needs:

1. Fuzzy find files `<leader>ff`
1. Fuzzy grep files `<leader>fg`

I also have `<leader>sg` (source graph) - but it is only useful when dealing
with huge repositories.

I like floating windows (instead of splits) because floating window gives more
space (not too narrow that I can't see the full file path) and not too short
that I can't see much from preview.

I also like floating window for me file tree explorer, because huge repository
can have deep nested directories or long file names and to be able to see the
full path is a big plus to me.

### [neotree.lua](lua/config/neotree.lua)

It is a file exploer that is essential to day to day work - adding new files
at a specific directory, and deleting a specific file, or renaming a file. A
file explorer does all that. Neotree has a lot of features, but I never need
anything else more than that.

One thing to note though - Neovim can be slow in huge repository because there
can be many paths to traverse. Truth is that I almostly never need to look at
something from repository root - I always use `<leader>ff` to find the file
first, and then `<leader>nr` (neotree reveal) to reveal the file in its parent
directory. That is instant. If I do need to open from root, I use `<leader>nt`
(neotree toggle). And even that, I often time pin a directory to work with
rather than working from repository root with `<leader>tp` (tab pin) or
`<leader>wp` (window pin).

### [lsp.lua](lua/config/lsp.lua)

I can't imagine a world where lsp integration doesn't exist. The way to look
up function signature (or auto completion), find definition, or find references
are all essential to code browsering - I keep the shortest keymaps for them:

`<leader>f`: format (high)
`<leader>d`: definition (high)
`<leader>r`: references (high)
`<leader>h`: help (show help like function signature)
`<leader>e`: show errors (medium)
`<leader>a`: show actions for quick fix (medium)
`<leader>n`: reName (medium)
`<leader>t`: type definitions (medium)
`<leader>D`: declaration (low)
`<leader>I`: implementations

### [toggleterm.lua](lua/config/toggleterm.lua)

This is where I prefer a bottom terminal buffer instead of a floating window
without clear reason - likely a habbit that I haven't adjusted to.

`<leader>tb`: terminal at bottom as a split
`<leader>tf`: terminal in floating window
