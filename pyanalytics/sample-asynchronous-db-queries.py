#!.venv/bin/python

# 4. Asynchronous Database Queries

# Explanation:
# - asyncpg is a fast PostgreSQL client library that supports asynchronous operations.
# - Using a connection pool improves performance by reusing database connections.
# - conn.fetch performs the database query asynchronously.

# Key Concepts:
# - async and await: These keywords are used to define and call asynchronous functions.
# - Event Loop: The event loop manages the execution of asynchronous tasks.
# - asyncio.gather: This function runs multiple asynchronous tasks concurrently.
# - aiohttp: A library for asynchronous HTTP requests and web servers.
# - asyncpg: A library for asynchronous PostgreSQL database interactions.
# - loop.run_in_executor: used to run blocking functions within the asyncio event loop.

import os
import asyncio
import asyncpg
from dotenv import load_dotenv

load_dotenv()

HOST = os.getenv('PG_HOST')
PORT = os.getenv('PG_PORT')
DB = os.getenv('PG_DB')
USER = os.getenv('PG_USER')
PASS = os.getenv('PG_PASS')

async def fetch_data(pool, table):
    async with pool.acquire() as conn:
        rows = await conn.fetch(f"SELECT * FROM {table}")
        return rows

async def main(user, pw, db, tbl, host=HOST, port=PORT):
    pool = await asyncpg.create_pool(user=user, password=pw, database=db, host=host, port=port)
    data = await fetch_data(pool, tbl)
    await pool.close()
    print(data)

if __name__ == "__main__":
    asyncio.run(main(user=USER,
                     pw=PASS,
                     db=DB,
                     tbl='student',
                     host=HOST,
                     port=PORT))