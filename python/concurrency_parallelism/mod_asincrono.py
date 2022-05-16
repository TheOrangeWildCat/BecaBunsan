import asyncio
import time
import aiohttp
import os
import threading
from datetime import datetime


async def download_site(session, url):
    async with session.get(url) as response:
        print(f"Read {response.content_length} from {url}| timestamp: {datetime.now()} process_id: {os.getpid()} thread: {threading.current_thread().name}")


async def download_all_sites(sites):
    async with aiohttp.ClientSession() as session:
        tasks = []
        for url in sites:
            task = asyncio.ensure_future(download_site(session, url))
            tasks.append(task)
        await asyncio.gather(*tasks, return_exceptions=True)


if __name__ == "__main__":
    sites = [
        "https://www.jython.org",
        "http://olympus.realpython.org/dice",
    ] * 80
    start_time = time.time()
    asyncio.get_event_loop().run_until_complete(download_all_sites(sites))
    duration = time.time() - start_time
    print(f"Downloaded {len(sites)} sites in {duration} seconds")
