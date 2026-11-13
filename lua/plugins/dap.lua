return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Required dependency for dap-ui
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Initialize the UI
		dapui.setup()

		-- Automatically open and close the UI when debugging starts/stops
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Keymaps for debugging
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end, { desc = "Debug: Conditional Breakpoint" })

		-- Wokwi / Embedded GDB Adapter
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb", -- Change to xtensa-esp32-elf-gdb if using specific Espressif toolchain
			args = { "-i", "dap" }
		}

		dap.configurations.c = {
			{
				name = "Attach to Wokwi Simulator",
				type = "gdb",
				request = "attach",
				target = "localhost:3333",
				program = function()
					return vim.fn.input('Path to elf: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = "${workspaceFolder}",
			}
		}
	end,
}
