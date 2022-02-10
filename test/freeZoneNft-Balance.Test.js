const { accounts, contract } = require('@openzeppelin/test-environment');
const { time } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

const freeZoneNft = contract.fromArtifact('freeZoneNft');
const freeZoneMapping = contract.fromArtifact('freeZoneMapping');
const freeZoneStorage = contract.fromArtifact('freeZoneStorage');

contract('balance', function ([sender, receiver]) {
  describe('current', function () {
    const [dev, owner, user1] = accounts;
    it('returns the current balance of an account as a BN in wei', async function () {
      expect(await balance.current(sender)).to.be.bignumber.equal(await web3.eth.getBalance(sender));
    });

    it('returns the current balance of an account as a BN in a specified unit', async function () {
      expect(await balance.current(sender, 'ether')).to.be.bignumber.equal(
        fromWei(await web3.eth.getBalance(sender), 'ether')
      );
    });
  });

  describe('balance tracker', function () {
    describe('default unit (wei)', function () {
      it('returns current balance ', async function () {
        const tracker = await balance.tracker(receiver);
        expect(await tracker.get()).to.be.bignumber.equal(await web3.eth.getBalance(receiver));
      });

      it('get() adds a new checkpoint ', async function () {
        const tracker = await balance.tracker(sender);
        await send.ether(sender, receiver, ether('1'));
        await tracker.get();
        expect(await tracker.delta()).to.be.bignumber.equal('0');
      });

      it('returns correct deltas after get() checkpoint', async function () {
        const tracker = await balance.tracker(receiver);
        await send.ether(sender, receiver, ether('1'));
        await tracker.get();
        await send.ether(sender, receiver, ether('1'));
        expect(await tracker.delta()).to.be.bignumber.equal(ether('1'));
      });

      it('returns balance increments', async function () {
        const tracker = await balance.tracker(receiver);
        await send.ether(sender, receiver, ether('1'));
        expect(await tracker.delta()).to.be.bignumber.equal(ether('1'));
      });

      it('returns balance decrements', async function () {
        const tracker = await balance.tracker(sender);
        await send.ether(sender, receiver, ether('1'));
        const { delta, fees } = await tracker.deltaWithFees();
        expect(delta.add(fees)).to.be.bignumber.equal(ether('-1'));
      });

      it('returns consecutive deltas', async function () {
        const tracker = await balance.tracker(sender);
        await send.ether(sender, receiver, ether('1'));
        await tracker.delta();
        expect(await tracker.delta()).to.be.bignumber.equal('0');
      });
    });

    describe('user-provided unit', function () {
      const unit = 'gwei';

      beforeEach(async function () {
        this.tracker = await balance.tracker(receiver, unit);
      });

      it('returns current balance in tracker-specified unit', async function () {
        expect(await this.tracker.get()).to.be.bignumber.equal(fromWei(await web3.eth.getBalance(receiver), unit));
      });

      it('returns deltas in tracker-specified unit', async function () {
        await send.ether(sender, receiver, ether('1'));
        expect(await this.tracker.delta()).to.be.bignumber.equal(fromWei(ether('1'), unit));
      });

      describe('overrides', function () {
        const override = 'nanoether';

        it('returns current balance in overridden unit', async function () {
          expect(await this.tracker.get(override)).to.be.bignumber.equal(
            fromWei(await web3.eth.getBalance(receiver), override)
          );
        });

        it('returns deltas in overridden unit', async function () {
          await send.ether(sender, receiver, ether('1'));
          expect(await this.tracker.delta(override)).to.be.bignumber.equal(fromWei(ether('1'), override));
        });
      });
    });
  });
});
