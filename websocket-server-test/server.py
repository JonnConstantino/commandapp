#!/usr/bin/env python3

import asyncio
import websockets
import json

port = 8765
print("WebSocket Server ouvindo na porta " + str(port))

async def hello(websocket, path):
	while True:
		data = await websocket.recv()
		print("")
		print("Comando recebido:")
		print("------------------------------")
		print(data)


start_server = websockets.serve(hello, 'localhost', port)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()