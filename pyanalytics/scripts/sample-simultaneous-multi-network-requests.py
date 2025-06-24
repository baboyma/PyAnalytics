#!.venv/bin/python

# Description: Asynchronous programming in Python, primarily using asyncio, allows you to write concurrent code that can handle multiple tasks without waiting for each one to complete sequentially. This is especially useful for I/O-bound operations like network requests, file I/O, and database interactions. Here are some good examples:
# Source: Gemini 2.0 Flash
# 1. Making Multiple Network Requests Simultaneously:

import asyncio
import aiohttp

async def get_content(session, url):
    async with session.get(url) as response:
        print(f"Status: {response.status}, Content-type: {response.headers['content-type']}")
        return await response.text()

async def main():
    urls = [
        "https://www.example.com",
        "https://www.google.com",
        "https://www.python.org"
    ]

    async with aiohttp.ClientSession() as session:
        tasks = [get_content(session, url) for url in urls]
        results = await asyncio.gather(*tasks)

    for result in results:
        # print 1st 100 chars of each results
        print(result[:100])

if __name__ == "__main__":
    asyncio.run(main())