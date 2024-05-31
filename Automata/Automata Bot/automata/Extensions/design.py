import hikari
import lightbulb
import miru


design_command = lightbulb.Plugin("design")


@design_command.command
@lightbulb.command("design", "Design an automation.")
@lightbulb.implements(lightbulb.SlashCommandGroup)
async def design_cmd(ctx: lightbulb.SlashCommandGroup) -> None:
    ...
    

@design_cmd.child
@lightbulb.command("nfa", "Design a non-deterministic finite automation")
@lightbulb.implements(lightbulb.SlashSubCommand)
async def nfa_cmd(ctx: lightbulb.SlashSubCommand) -> None:
    await ctx.interaction.create_initial_response(
        hikari.ResponseType.MESSAGE_CREATE,
        "Hi"
    )
    return

def load(bot: lightbulb.BotApp):
    bot.add_plugin(design_command)