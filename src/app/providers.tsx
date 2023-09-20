"use client";

import { SessionProvider } from "next-auth/react";
import * as React from 'react';
import {
  RainbowKitProvider,
  getDefaultWallets,
  connectorsForWallets,
} from '@rainbow-me/rainbowkit';
import {
  argentWallet,
  trustWallet,
  ledgerWallet,
} from '@rainbow-me/rainbowkit/wallets';
import { configureChains, createConfig, WagmiConfig } from 'wagmi';
import {
  mainnet,
  polygon,
  optimism,
  arbitrum,
  base,
  zora,
  goerli,
} from 'wagmi/chains';
import { publicProvider } from 'wagmi/providers/public';
import { alchemyProvider } from 'wagmi/providers/alchemy';

const { chains, publicClient, webSocketPublicClient } = configureChains(
  [mainnet, polygon, optimism, arbitrum, base, zora],
  [
    alchemyProvider({ apiKey: '79elEBQkIJDgqEshlnrgUhYdmo94tN_L'}),
    publicProvider()
  ]
);

const projectId = '6c1e09f6c1dcf8014f23ed25448c9228'
const projectName = 'CHROracle'

const { wallets } = getDefaultWallets({
  appName: projectName,
  projectId: projectId,
  chains,
});

const chroracle = {
  appName: projectName,
};

const connectors = connectorsForWallets([
  ...wallets,
  {
    groupName: 'Other',
    wallets: [
      argentWallet({ projectId, chains }),
      trustWallet({ projectId, chains }),
      ledgerWallet({ projectId, chains }),
    ],
  },
]);

const wagmiConfig = createConfig({
  autoConnect: true as boolean,
  connectors,
  publicClient,
  webSocketPublicClient,
});
type Props = {
  children?: React.ReactNode;
};

export const NextAuthProvider = ({ children }: Props) => {
  const [mounted, setMounted] = React.useState(false);
  React.useEffect(() => setMounted(true), []);
  return (
    <WagmiConfig config={wagmiConfig}>
      <RainbowKitProvider chains={chains} appInfo={chroracle}>
        <SessionProvider >
          {mounted && children}
        </SessionProvider>
      </RainbowKitProvider>
    </WagmiConfig>
  );
};
