Inspired by https://medium.com/@goodatsports/how-to-make-a-simple-discord-bot-in-ruby-to-annoy-your-friends-f5d0438daa70

# Discord setup

1. Create Discord application
2. Add bot to server
3. Invite bot to your server
   - https://discordapp.com/oauth2/authorize?client_id=<ID>&scope=bot&permissions=36703232
   - https://discordapi.com/permissions.html#36703232

# Run / Develop / Deploy

1. Install docker and docker-compose.
2. Clone repo
3. Setup `.env` file (copy `.env.sample` and fill it)
4. `make`

Stop with `make clean`.
