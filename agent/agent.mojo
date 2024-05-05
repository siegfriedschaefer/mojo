
from collections.vector import InlinedFixedVector

struct Role:
    alias AGENT = 1
    alias USER = 2
    alias SYSTEM = 3

struct ROLE:
    var role: Int

    alias AGENT = ROLE(1)
    alias USER = ROLE(2)
    alias SYSTEM = ROLE(3)

    fn __init__(inout self, role: Int) :
        self.role = role


struct Message :
    var text: String
    var role: ROLE
    var arole: Role

    fn __init__(inout self, text: String, role: ROLE) :
        self.text = text
        self.role = role
        self.arole = Role.AGENT


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
        var message = Message(text = input, role = ROLE.USER)
        self.history[0] = message
        return input


def main():
    var agent = Agent(model_ref = "llama3", sys_prompt = "user")
    var result = agent.prompt('hello')

    print("system: " + agent.sys_prompt)
    print("model: " + agent.model_ref)
    print("result: " + result)


