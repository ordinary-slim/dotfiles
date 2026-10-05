local M = {}

function M.remap_workspace(from, to)
    if from == to then
        return true
    end

    local function renumber(source, target)
        hl.dispatch(hl.dsp.workspace.change_id({
            workspace = source,
            id = target,
        }))
    end

    if hl.get_workspace(to) then
        -- Find a temporary ID that is currently unused.
        local tmp = 6
        while hl.get_workspace(tmp) do
            tmp = tmp + 1
        end

        renumber(to, tmp)
        renumber(from, to)
        renumber(tmp, from)
    else
        renumber(from, to)
    end

    hl.exec_cmd("hyprctl reload")
    return true
end

function M.remap_current_workspace(to)
  return M.remap_workspace(hl.get_active_workspace().id, to)
end

return M
