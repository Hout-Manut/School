import hikari
import lightbulb
import miru


minimize_command = lightbulb.Plugin("minimize")


@minimize_command.command
@lightbulb.command("minimize", "Minimize a FA")
@lightbulb.implements(lightbulb.SlashCommandGroup)
async def minimize_cmd(ctx: lightbulb.SlashCommandGroup) -> None:
    ...


@minimize_cmd.child
@lightbulb.command("dfa", "Minimize a DFA")
@lightbulb.implements(lightbulb.SlashSubCommand)
async def nfa_cmd(ctx: lightbulb.SlashSubCommand) -> None:
    await ctx.interaction.create_initial_response(
        hikari.ResponseType.MESSAGE_CREATE,
        "Hi"
    )
    return


def load(bot: lightbulb.BotApp):
    bot.add_plugin(minimize_command)
