const { TestHelper } = require('zos');

const LotteryGame8 = artifacts.require('LotteryGame8')

contract('LotteryGame8', function ([_, owner]) {
    beforeEach(async function () {
        this.project = await TestHelper({ from: owner })
    })

    it('should create a proxy', async function () {
        const proxy = await this.project.createProxy(LotteryGame8);
        console.log(await proxy.winner())
        console.log(await proxy.numRounds())
        console.log(await proxy.numParticipants())
      })
})