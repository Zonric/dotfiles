local M = {}

local acp_script = vim.fn.stdpath("config") .. "/scripts/agy-acp"

-- Clean and speak text asynchronously via tts-say
function M.speak(text)
	if not text or text == "" then
		return
	end

	-- Strip markdown code blocks, backticks, and headers
	local clean = text:gsub("```.-```", ""):gsub("`.-`", ""):gsub("#+%s*", "")
	clean = vim.trim(clean)
	if clean == "" then
		return
	end

	local job = vim.fn.jobstart({ "tts-say" }, {
		stdin = "pipe",
	})
	if job > 0 then
		vim.fn.chansend(job, clean)
		vim.fn.chanclose(job, "stdin")
	end
end

-- Stop any active audio playback
function M.stop_speaking()
	vim.fn.jobstart({ "pkill", "-f", "mpv --no-terminal --really-quiet -" })
end

M.codecompanion_opts = {
	adapters = {
		acp = {
			antigravity = function()
				return {
					name = "antigravity",
					formatted_name = "Antigravity CLI",
					type = "acp",
					roles = {
						llm = "assistant",
						user = "user",
					},
					commands = {
						default = {
							acp_script,
						},
					},
					defaults = {
						timeout = 60000,
					},
					parameters = {
						protocolVersion = 1,
						clientCapabilities = {
							fs = { readTextFile = true, writeTextFile = true },
						},
						clientInfo = {
							name = "CodeCompanion.nvim",
							version = "1.0.0",
						},
					},
					handlers = {
						setup = function()
							return true
						end,
						form_messages = function(self, messages, capabilities)
							return require("codecompanion.adapters.acp.helpers").form_messages(
								self,
								messages,
								capabilities
							)
						end,
					},
				}
			end,
		},
	},
	interactions = {
		chat = {
			adapter = "antigravity",
			opts = {
				completion_provider = "blink",
			},
		},
		inline = {
			adapter = "antigravity",
		},
		cli = {
			agent = "antigravity",
			agents = {
				antigravity = {
					cmd = "agy",
					args = { "-c" },
					description = "Antigravity CLI",
					provider = "terminal",
				},
			},
			opts = {
				auto_insert = true,
				reload = true,
			},
		},
	},
	display = {
		chat = {
			window = {
				layout = "vertical",
				width = 0.35,
				opts = {
					number = false,
					relativenumber = false,
				},
			},
		},
	},
	opts = {
		log_level = "DEBUG",
	},
}

-- CodeCompanion Request Finished autocommand to trigger TTS
vim.api.nvim_create_autocmd("User", {
	pattern = "CodeCompanionRequestFinished",
	callback = function(request)
		local data = request.data or {}
		if data.status and data.status ~= "success" then
			return
		end

		local bufnr = data.bufnr or request.buf
		local chat = nil

		if data.chat then
			chat = data.chat
		elseif bufnr and bufnr > 0 then
			local ok, cc = pcall(require, "codecompanion")
			if ok and cc.buf_get_chat then
				chat = cc.buf_get_chat(bufnr)
			end
		end

		if chat and chat.messages and #chat.messages > 0 then
			local last_msg = chat.messages[#chat.messages]
			if last_msg.role == "llm" and last_msg.content then
				M.speak(last_msg.content)
			end
		end
	end,
})

return M
