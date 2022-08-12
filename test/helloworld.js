const HelloWorld = artifacts.require('HelloWorld');

contract("HelloWorld", () => {
    it("testing",async () => {
        const instance = await HelloWorld.deployed();
        await instance.setMessage("Hello pk");
        const message = await instance.message();
        assert(message == "Hello pk");
    })
})