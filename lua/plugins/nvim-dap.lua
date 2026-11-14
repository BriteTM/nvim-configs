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
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint" })

		-- probe-rs DAP Adapter for Physical ESP32-C3
		dap.adapters["probe-rs-debug"] = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.expand("~/.cargo/bin/probe-rs"),
				args = { "dap-server", "--port", "${port}" },
			},
		}

		dap.listeners.before["event_probe-rs-rtt-channel-config"]["plugins.nvim-dap-probe-rs"] = function(
		    session, body)
			session:request("rttWindowOpened", { body.channelNumber, true })
		end

		dap.listeners.before["event_probe-rs-rtt-data"]["plugins.nvim-dap-probe-rs"] = function(_, body)
			require("dap.repl").append(body.data)
		end

		-- Flash & Debug Configuration for Rust on ESP32-C3
		dap.configurations.rust = {
			{
				name = "Flash & Debug Physical ESP32-C3",
				type = "probe-rs-debug",
				request = "launch",
				cwd = "${workspaceFolder}",
				chip = "esp32c3",
				flashingConfig = {
					flashingEnabled = true,
					haltAfterReset = false,
				},
				coreConfigs = {
					{
						coreIndex = 0,
						programBinary = function()
							local root = vim.fs.root(0, "Cargo.toml") or vim.fn.getcwd()
							vim.notify("Building Rust firmware...", vim.log.levels.INFO)
							local out = vim.fn.system({ "cargo", "build", "--manifest-path",
								root .. "/Cargo.toml" })
							if vim.v.shell_error ~= 0 then
								vim.notify("Cargo build failed:\n" .. out,
									vim.log.levels.ERROR)
								return nil
							end
							local pkg_name = vim.fn.system({
								"cargo", "metadata", "--no-deps", "--format-version", "1",
								"--manifest-path", root .. "/Cargo.toml"
							})
							local decoded = vim.json.decode(pkg_name)
							local bin_name = decoded.packages[1].targets[1].name
							return root ..
							    "/target/riscv32imc-unknown-none-elf/debug/" .. bin_name
						end,
					},
				},
			},
		}
	end,
}
