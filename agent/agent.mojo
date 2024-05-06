
from collections import List

alias LLM_ROLE_AGENT = 1
alias LLM_ROLE_USER = 2
alias LLM_ROLE_SYSTEM = 3

struct Message :
    var text: String
    var role: Int

    fn __init__(inout self, text: String, role: Int = LLM_ROLE_USER):
        self.text = text
        self.role = role

    fn __copyinit__(inout self, existing: Self):
        self.text = existing.text
        self.role = existing.role        

    fn __moveinit__(inout self, owned existing: Self):
        self.text = existing.text
        self.role = existing.role        

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
    var history: List[Message]


    fn __init__(inout self, sys_prompt: String, model_ref: String) :
        self.sys_prompt = sys_prompt
        self.model_ref = model_ref
        self.history = List[Message]()

    fn prompt(inout self, input: String) -> String:
        var message = Message(text = input, role = LLM_ROLE_USER)
        self.history.append(message)
        return input


def main():
    var agent = Agent(model_ref = "llama3", sys_prompt = "user")
    var result = agent.prompt('hello')

    var message = agent.history.pop()

    print("system: " + agent.sys_prompt)
    print("model: " + agent.model_ref)
    print("result: " + result)
    print("message: " + message.text + " role: " + message.role)

