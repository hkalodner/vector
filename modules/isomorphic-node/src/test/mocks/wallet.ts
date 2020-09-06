import { fake } from 'sinon';

import { IWalletService } from '../../app/core/definitions/wallet';

export const mockWalletService: IWalletService = {
  getPublicIdentifier: fake(() => {
    return;
  }),
  setup: fake(() => {
    return;
  }),
  create: fake(() => {
    return;
  }),
  deposit: fake(() => {
    return;
  }),
  withdraw: fake(() => {
    return;
  }),
  resolve: fake(() => {
    return;
  }),
};
