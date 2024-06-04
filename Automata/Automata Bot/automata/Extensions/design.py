import hikari
import lightbulb
import miru

import automata

design_command = lightbulb.Plugin("design")


@design_command.command
@lightbulb.command("design", "Design an automation.")
@lightbulb.implements(lightbulb.SlashCommand)
async def design_cmd(ctx: lightbulb.SlashContext) -> None:
    ...


def load(bot: lightbulb.BotApp):
    bot.add_plugin(design_command)
