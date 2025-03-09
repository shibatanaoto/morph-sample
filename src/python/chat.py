from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from morph_lib.stream import stream_chat

import morph
from morph import MorphGlobalContext
from morph_lib.stream import stream_chat

@morph.func
async def langchain_chat(context: MorphGlobalContext):
    llm = ChatOpenAI(model="gpt-4o")
    messages = [HumanMessage(context.vars["prompt"])]
    for token in llm.stream(messages):
        yield token.content
