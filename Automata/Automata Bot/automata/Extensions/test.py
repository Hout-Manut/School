import hikari
import lightbulb
import miru


test_command = lightbulb.Plugin("test")

@test_command.command
@lightbulb.command("test", "Testing")
@lightbulb.implements(lightbulb.SlashCommandGroup)
async def test_cmd(ctx: lightbulb.SlashCommandGroup) -> None:
    ...


@test_cmd.child
@lightbulb.command("fa", "Test if the FA is deterministic or not")
@lightbulb.implements(lightbulb.SlashSubCommand)
async def test_fa_cmd(ctx: lightbulb.SlashSubCommand) -> None:
    await ctx.interaction.create_initial_response(
        hikari.ResponseType.MESSAGE_CREATE,
        "Hi"
    )
    return


@test_cmd.child
@lightbulb.command("string", "Test if the string is accepted or not")
@lightbulb.implements(lightbulb.SlashSubCommand)
async def test_str_cmd(ctx: lightbulb.SlashSubCommand) -> None:
    await ctx.interaction.create_initial_response(
        hikari.ResponseType.MESSAGE_CREATE,
        "Hi"
    )
    return


def load(bot: lightbulb.BotApp):
    bot.add_plugin(test_command)
