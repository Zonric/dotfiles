local M = {}

function M.setup()
	local dap = require("dap")
	local dapui = require("dapui")

	dapui.setup()
	require("nvim-dap-virtual-text").setup({})

	local function open_and_focus_console()
		dapui.open()
		vim.schedule(function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_is_valid(win) then
					local buf = vim.api.nvim_win_get_buf(win)
					if
						vim.bo[buf].filetype == "dapui_console" or vim.api.nvim_buf_get_name(buf):match("DAP Console")
					then
						vim.api.nvim_set_current_win(win)
						vim.cmd("startinsert")
						break
					end
				end
			end
		end)
	end

	dap.listeners.before.attach.dapui_config = function()
		open_and_focus_console()
	end

	dap.listeners.before.launch.dapui_config = function()
		open_and_focus_console()
	end

	vim.api.nvim_create_autocmd("TermClose", {
		callback = function(args)
			local buf = args.buf
			if vim.bo[buf].filetype == "dapui_console" or vim.api.nvim_buf_get_name(buf):match("DAP Console") then
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(buf) then
						vim.cmd("stopinsert")
					end
				end)
			end
		end,
	})

	dap.listeners.before.event_terminated.dapui_config = nil
	dap.listeners.before.event_exited.dapui_config = nil

	-- Signs
	vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "DapStopped", linehl = "DebugLineHL", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "🔶", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "⚠️", texthl = "DapBreakpoint", linehl = "", numhl = "" })

	-- Adapters
	dap.adapters.lldb = {
		type = "executable",
		command = "lldb-dap",
		name = "lldb",
	}
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "-i", "dap" },
	}
	dap.adapters.go = {
		type = "server",
		port = "${port}",
		executable = {
			command = "dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		},
	}
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "js-debug-adapter",
			args = { "${port}" },
		},
	}

	dap.configurations.go = {
		{
			type = "go",
			name = "Debug package",
			request = "launch",
			program = "${fileDirname}",
			outputMode = "remote",
		},
		{
			type = "go",
			name = "Debug package (attached)",
			mode = "remote",
			request = "attach",
			port = "38453",
			host = "127.0.0.1",
		},
		{
			type = "go",
			name = "Debug file",
			request = "launch",
			program = "${file}",
			outputMode = "remote",
		},
		{
			type = "go",
			name = "Debug test",
			request = "launch",
			mode = "test",
			program = "${file}",
			outputMode = "remote",
		},
	}

	dap.configurations.cpp = {
		{
			name = "Launch gdb",
			type = "gdb",
			request = "launch",
			program = function()
				return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			sourceMap = {
				[vim.fn.getcwd() .. "/src"] = "src",
			},
			stopOnEntry = false,
			args = {},
		},
		{
			name = "Launch lldb",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
			end,
			cwd = "${workspaceFolder}",
			sourceMap = {
				[vim.fn.getcwd() .. "/src"] = "src",
			},
			stopOnEntry = false,
			args = {},
		},
	}
	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp

	local js_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
	for _, language in ipairs(js_languages) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file (Node)",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to process",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
	end

	dap.configurations.java = {}
	if dap.providers and dap.providers.configs then
		dap.providers.configs["zz_java_remote"] = function(bufnr)
			if vim.bo[bufnr].filetype ~= "java" then
				return {}
			end
			return {
				{
					type = "java",
					request = "attach",
					name = "Attach to Remote Debugger",
					hostName = "127.0.0.1",
					port = function()
						return tonumber(vim.fn.input("Port: ", "5005"))
					end,
				},
			}
		end
	end
end

return M
