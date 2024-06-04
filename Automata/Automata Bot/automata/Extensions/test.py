import hikari
import lightbulb
import miru

import automata

test_command = lightbulb.Plugin("test")


@test_command.command
@lightbulb.command("test", "Testing")
@lightbulb.implements(lightbulb.SlashCommandGroup)
async def test_cmd(ctx: lightbulb.SlashContext) -> None: ...


@test_cmd.child
@lightbulb.command("fa", "Test if the FA is non-deterministic or deterministic")
@lightbulb.implements(lightbulb.SlashSubCommand)
async def test_fa_cmd(ctx: lightbulb.SlashContext) -> None:
    view = automata.FormView(ctx, timeout=300)
    embed = hikari.Embed(title="Finite Automation Test", description="Please enter the FA data.")
    await ctx.interaction.create_initial_response(
        hikari.ResponseType.MESSAGE_CREATE, embed=embed, components=view
    )
    message = await ctx.app.rest.fetch_message(ctx.channel_id, ctx.interaction.id)
    
    


    return


@test_cmd.child
@lightbulb.command("string", "Test if the string is accepted or not")
@lightbulb.implements(lightbulb.SlashSubCommand)
async def test_str_cmd(ctx: lightbulb.SlashContext) -> None:
    await ctx.interaction.create_initial_response(
        hikari.ResponseType.MESSAGE_CREATE, "Hi"
    )
    return


def load(bot: lightbulb.BotApp):
    bot.add_plugin(test_command)
