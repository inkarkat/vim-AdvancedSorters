ADVANCED SORTERS
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

The built-in :sort command is powerful, but it still is line-based. It
doesn't take into account folded lines, nor can it sort entire blocks like
function definitions, paragraphs, etc. But often, one needs to sort exactly
such areas as single entities, i.e. without changing the line order within
them. A workaround in Vim is condensing each block into a single line,
performing the sorting, and then expanding again. (External, more powerful
sort commands could be used, too.)

This plugin implements this workaround and encapsulates the three separate
steps in one handy command.

While :sort has several flags for sorting on various numbers, and a
/{pattern}/ can be specified to skip or sort on, it doesn't allow arbitrary
(Vimscript) expressions.

This plugin offers extension commands that evaluate an expression per line,
put that number in front of the line, do a numerical sort, and then remove the
temporary number again. Specializations handle the common sort by number of
characters and by the line's display width.

### SOURCE

- [:SortVisible inspiration](http://stackoverflow.com/questions/13554191/sorting-vim-folds)
- [:SortRangesByRange inspiration](http://superuser.com/questions/752032/how-do-i-sort-multiple-blocks-of-text-by-the-first-line-in-each-block-in-vim)
- [:SortByExpr inspiration](http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length)
- [:SortWORDs inspiration](http://stackoverflow.com/questions/26739697/sort-line-horizontally-in-vim)
  http://stackoverflow.com/questions/1327978/sorting-words-not-lines-in-vim

### SEE ALSO

- The LineJuggler.vim plugin ([vimscript #4140](http://www.vim.org/scripts/script.php?script_id=4140)) offers many quick mappings to
  move around (blocks of) lines. For small data sets, manual shifting may be
  quicker than coming up with a correct sort command.

USAGE
------------------------------------------------------------------------------

    :[range]SortVisible[!] [i][u][r][n][x][o] [/{pattern}/]
                            Sort visible lines in the buffer / [range]. Lines
                            inside closed folds are kept intact; sorting is done
                            on all lines of the fold as one unit; i.e. the order
                            of the other lines inside the fold does _not_ change!

    :[range]SortRangesByHeader[!] /{expr}/ [i][u][r][n][x][o] [/{pattern}/]
                            Each match of {expr} (in the buffer / [range]) starts
                            a new area that sorts as one unit; i.e. the order of
                            the other lines inside the area does _not_ change!
                            Lines before the first header are sorted individually.

    :[range]SortRangesByMatch[!] /{expr}/ [i][u][r][n][x][o] [/{pattern}/]
                            Each (multi-line) match of {expr} (in the buffer /
                            [range]) defines an area that sorts as one unit,
                            together with individual non-matching lines.

    :[range]SortRangesByRange[!] {range} [i][u][r][n][x][o] [/{pattern}/]
                            Each {range} (in the buffer / [range]) defines an area
                            that sorts as one unit.
                            Note: For this command, /{pattern}/ must be separated
                            from the {range} by a [i][u][r][n][x][o] flag or a
                            space; you cannot directly concatenate them.

                            Note: The text must not contain embedded <Nul>
                            characters (^@) for the above commands!

    :[range]ReorderVisible {reorder-expr}
                            Reorder visible lines in the buffer / [range] by
                            collecting into a List of Strings (multiple folded
                            lines are joined with newlines) and passing it (as
                            v:val) to {reorder-expr}.

    :[range]ReorderFolded {reorder-expr}
                            Reorder folded lines in the buffer / [range] by
                            collecting into a List of Strings (multiple folded
                            lines are joined with newlines) and passing it (as
                            v:val) to {reorder-expr}. Those are then re-inserted
                            in between any unfolded lines, which stay as they
                            were.

    :[range]ReorderUnfolded {reorder-expr}
                            Reorder unfolded lines in the buffer / [range] by
                            collecting into a List of Strings (subsequent unfolded
                            lines are joined with newlines) and passing it (as
                            v:val) to {reorder-expr}. Those are then re-inserted
                            in between any closed folds, which stay as they were.

    :[range]ReorderByHeader /{expr}/ {reorder-expr}
                            Each match of {expr} (in the buffer / [range]) starts
                            a new area that is reordered as one unit (joined with
                            newlines) by passing it (as v:val) to {reorder-expr}.
                            Lines before the first header are reordered as another
                            single unit.

    :[range]ReorderOnlyByMatch /{expr}/ {reorder-expr}
                            Each (multi-line) match of {expr} (in the buffer /
                            [range]) defines an area that is reordered as one unit
                            (joined with newlines) by passing it (as v:val) to
                            {reorder-expr}. Those are then re-inserted in between
                            any non-matching lines, which stay as they were.

    :[range]ReorderByMatchAndNonMatches /{expr}/ {reorder-expr}
                            Each (multi-line) match of {expr} (in the buffer /
                            [range]) defines an area that is reordered as one unit
                            (joined with newlines), together with units of
                            non-matching lines, by passing it (as v:val) to
                            {reorder-expr}.

    :[range]ReorderByMatchAndLines /{expr}/ {reorder-expr}
                            Each (multi-line) match of {expr} (in the buffer /
                            [range]) defines an area that is reordered as one unit
                            (joined with newlines), together with individual
                            non-matching lines, by passing it (as v:val) to
                            {reorder-expr}.

    :[range]ReorderOnlyByRange {range} {reorder-expr}
                            Each {range} (in the buffer / [range]) defines an area
                            that is reordered as one unit (joined with newlines),
                            by passing it (as v:val) to {reorder-expr}. Those are
                            then re-inserted in between any non-matching lines,
                            which stay as they were.

    :[range]ReorderByRangeAndNonMatches {range} {reorder-expr}
                            Each {range} (in the buffer / [range]) defines an area
                            that is reordered as one unit (joined with newlines),
                            together with individual non-matching lines, by
                            passing it (as v:val) to {reorder-expr}.

    :[range]ReorderByRangeAndLines {range} {reorder-expr}
                            Each {range} (in the buffer / [range]) defines an area
                            that is reordered as one unit (joined with newlines),
                            together with individual non-matching lines, by
                            passing it (as v:val) to {reorder-expr}.

    :[range]SortByExpr[!] {expr}
                            Sort lines in [range] by the {expr}, which should take
                            the current line as input via v:val and return a
                            number. With [!] the order is reversed.

    :[range]SortByExprUnique[!] {expr}
                            Sort lines in [range] by the {expr}; only the first
                            line that gets a certain number from {expr} is kept.
                            With [!] the order is reversed.

    :[range]SortByCharLength[!]
                            Sort lines in [range] by the number of characters.

    :[range]SortByWidth[!]
                            Sort lines in [range] by the display width.

    :[range]SortEach /{delimiter-pattern}/[{joiner}/]
    :[range]SortEach /{delimiter-pattern}/[{joiner}]/ [i][u][r][n][x][o] /{pattern}/
                            Sort individual elements delimited by
                            {delimiter-pattern} (or newlines) in the current line
                            / [range], and join them back together with the first
                            matching delimiter [or {joiner}].

    :[range]SortWORDs[!] [i][u][r][n][x][o] [/{pattern}/]
                            Sort individual (whitespace-delimited) WORDs in the
                            current line / [range].

    :[range]UniqAny [i][r] [/{pattern}/]
                            Remove lines in [range] that have already been
                            encountered earlier (not necessarily adjacent).
                            With [i] case is ignored.
                            When /{pattern}/ is specified and there is no [r] flag
                            the text matched with {pattern} is ignored.
                            With [r] only the matching {pattern} is considered;
                            the rest is ignored.
                            If a {pattern} is used, any lines which don't have a
                            match for {pattern} are kept.

    :[range]UniqSubsequent [i][r] [/{pattern}/]
                            Remove second and succeeding copies of repeated
                            adjacent lines in [range].
                            With [i] case is ignored.
                            When /{pattern}/ is specified and there is no [r] flag
                            the text matched with {pattern} is ignored.
                            With [r] only the matching {pattern} is considered;
                            the rest is ignored.
                            If a {pattern} is used, any lines which don't have a
                            match for {pattern} are kept.

### EXAMPLE

We're taking any Vimscript file with multiple function definitions as an
example, and show how to sort whole functions according to function name (and
arguments).

To use folding, we first have to define the folds, then trigger the sorting:

    :g/^function/,/^endfunction/fold
    :SortVisible

If we don't care about including any lines after the "endfunction", we can
just base the areas on the function start:

    :SortRangesByHeader /^function/

But we'll get better results with an explicit end. One way is to define a
multi-line pattern that covers the entire function:

    :SortRangesByMatch /^function\_.\{-}\nendfunction$/

Another way spans up a range, similar to what we've done above to define the
folds:

    :SortRangesByRange /^function/,/^endfunction$/

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-AdvancedSorters
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim AdvancedSorters*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.039 or
  higher.

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-AdvancedSorters/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### 1.30    03-Feb-2020
- CHG: Rename :Uniq to :UniqAny and add :UniqSubsequent variant.
- Add :SortEach generalization of :SortWORDs.
- CHG: Rename :SortUnfolded to :SortVisible.
- ENH: Add various :ReorderBy... commands that mirror the :SortVisible and
  :SortRangedBy... commands, but allow arbitrary reorderings via a Vimscript
  expression.

__You need to update to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.039!__

##### 1.21    26-Oct-2016
- BUG: :SortUnfolded and :SortRangedBy... remove comment sigils (like "#")
  when 'formatoptions' contains "j". Temporarily reset 'formatoptions' to
  avoid interference of user settings. Thanks to Holger Mitschke for reporting
  this!

##### 1.20    09-Feb-2015
- Add :Uniq command.
- Also support [/{pattern}/] [i][u][r][n][x][o] :sort argument order (and
  mixed).
- FIX: Include missing Words.vim module that prevented the :SortWORDs command
  introduced in the previous version 1.10 from functioning.

##### 1.10    23-Dec-2014
- Add :SortWORDs command.

##### 1.02    06-Nov-2014
- BUG: :.SortRangesBy... doesn't work correctly on a closed fold; need to use
  ingo#range#NetStart().

__You need to update to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.022!__

##### 1.01    10-Jul-2014
- Make :SortRangesByRange work for Vim versions before 7.4.218 that don't have
  uniq().

__You need to update to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.021!__

##### 1.00    11-Jun-2014
- First published version.

##### 0.01    18-Jul-2012
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2012-2020 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
