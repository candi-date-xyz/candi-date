# bot.py

""" crappy discord bot """


# https://discord.com/developers/docs/resources/guild

# https://discordpy.readthedocs.io/en/stable/

# https://discord.com/developers/applications/984363433338216458/bot

# https://www.youtube.com/watch?v=7HeKk9x-YrA

# https://discord.com/api/oauth2/authorize?client_id=984363433338216458&permissions=380104674368&scope=bot

import sys
import os

import discord
from dotenv import load_dotenv

class MyClient(discord.Client):
    async def on_ready(self):
        print('Logged on as {0}!'.format(self.user))

    async def on_message(self, message):
        print('Message from {0.author}: {0.content}'.format(message))

        if message.author == self.user:
            # ignore messages from ourself!
            return

        if message.content.startswith('$hello'):
            await message.channel.send('Hello!')



def hello():
    load_dotenv()
    TOKEN = os.getenv('DISCORD_TOKEN')
    GUILD = os.getenv('DISCORD_GUILD')



    print(f"TOKEN={TOKEN}")
    print(f"GUILD={GUILD}")

    client = discord.Client()

    client = MyClient()
    #client.run('my token goes here')

    # @client.event
    # async def on_ready():
    #     for guild in client.guilds:
    #         print(f"guild:{guild.name}")
    #         if guild.name == GUILD:
    #             break

    #     print(
    #         f'{client.user} is connected to the following guild:\n'
    #         f'{guild.name}(id: {guild.id})'
    #     )
    client.run(TOKEN)


def cli(args=None):
    """Process command line arguments."""
    if not args:
        args = sys.argv[1:]    
    # tz = args[0]
    print(hello())
