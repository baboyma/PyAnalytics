#!.venv/bin/python

# 3. Asynchronous Web Server
# Resources: https://docs.aiohttp.org/en/stable/index.html

import asyncio
import aiohttp.web

async def handle(request):
    name = request.match_info.get('name', 'Anonymous')
    text = f"Hello, {name}"
    return aiohttp.web.Response(text=text)

async def main():
    domain = '127.0.0.1'
    port = 8080

    app = aiohttp.web.Application()
    app.add_routes([aiohttp.web.get('/', handle),
                    aiohttp.web.get('/{name}', handle)])

    runner = aiohttp.web.AppRunner(app)

    await runner.setup()
    site = aiohttp.web.TCPSite(runner, domain, port)
    await site.start()

    print(f"Server started at http://{domain}:{port}")

    await asyncio.Event().wait() # Keep the server running

if __name__ == "__main__":
    asyncio.run(main())