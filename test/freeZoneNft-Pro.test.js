/* eslint-disable no-unused-expressions */
const { accounts, contract } = require('@openzeppelin/test-environment');
const { time } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

const freeZone = contract.fromArtifact('freeZone');

describe('freeZone', async function () {
  const [dev, owner, user1] = accounts;
  const MESSAGE = 'Welcome : you are register pro';
  const _MESSAGE = 'NEW MESSAGE';

  context('freeZone initial state', function () {
    
    beforeEach(async function () {
      this.freeZone = await freeZone.new(owner, MESSAGE, { from: dev });
    });

    it(`has message ${MESSAGE}`, async function () {
      expect(await this.freezone.getMessage()).to.equal(MESSAGE);
    });

    it('has owner', async function () {
      expect(await this.freezone.owner()).to.equal(owner);
    });

    it('has starting date', async function () {
      const _current = await time.latest();
      expect(await this.freezone.getStartDate()).to.be.a.bignumber.equal(_current);
    });
  });

  context('freeZone ownership', function () {
    beforeEach(async function () {
      this.freezone = await this.freezone.new(owner, MESSAGE, { from: dev });
    });
    it('set message', async function () {
      await this.freezone.setMessage(_MESSAGE, { from: owner });
      expect(await this.freezone.getMessage()).to.equal(_MESSAGE);
    });
  });
  context('freeZone time functions', function () {
    beforeEach(async function () {
      this.account = await freeZone.new(owner, MESSAGE, { from: dev });
    });
    it('handles not finished yet', async function () {
      expect(await this.freezone.goodbye({ from: user1 })).to.equal('not finished yet!!');
    });

    it('handles finished registre pro', async function () {
      await time.increase(time.duration.weeks(24));
      expect(await freezone.goodbye({ from: user1 })).to.equal('congratulations and goodbye!!');
    });
  });
});

