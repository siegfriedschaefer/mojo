
from collections.vector import InlinedFixedVector

struct Role:
    alias AGENT = 1
    alias USER = 2
    alias SYSTEM = 3


struct Message :
    var text: String
    var role: Role

    fn __init__(inout self, text: String, role: Role) :
        self.text = text
        self.role = role


struct Agent :
    """
    System message
    - defines purpose and behaviour of the agent.
    - primes LLM with instructions on how to behave and answer.
    """
    var sys_prompt: String

    """
    Model message
    - defines the model of the agent.
    """   
    var model_ref: String

    var history: InlinedFixedVector[Message]


    fn __init__(inout self, sys_prompt: String, model_ref: String) :
        self.sys_prompt = sys_prompt
        self.model_ref = model_ref
        self.history = InlinedFixedVector[Message](10)

    fn prompt(inout self, input: String) -> String:
        print("input: " + input)
        var message = Message(text = input, role = Role.USER)
        self.history[0] = message
        return input


def main():
    var agent = Agent(model_ref = "llama3", sys_prompt = "user")
    var result = agent.prompt('hello')

    print("system: " + agent.sys_prompt)
    print("model: " + agent.model_ref)
    print("result: " + result)


