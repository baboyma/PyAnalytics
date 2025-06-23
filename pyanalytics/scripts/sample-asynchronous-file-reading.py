#!.venv/bin/python

# 2. Asynchronous File I/O

import asyncio

async def read_file(filename):
    loop = asyncio.get_running_loop()
    with open(filename, 'r') as f:
        content = await loop.run_in_executor(None, f.read)
        return content

async def main():
    ffile = "./data/online_retail.csv"
    content = await read_file(filename=ffile)
    print(content[:1000])

if __name__ == "__main__":
    asyncio.run(main())