"use client";

import Link from "next/link";
import data from "./listNfts.json";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import ClearImage from "~~/components/cards/ClearImage";
import Carousel from "~~/components/carousels/Carousel";
import { Address } from "~~/components/scaffold-eth";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  return (
    <>
      <Carousel />
      <div className="flex grid-cols-4 gap-4">
        {data.map(e => (
          <ClearImage imageUri={e.imageUri} title={e.title} description={e.description} />
        ))}
      </div>
    </>
  );
};

export default Home;
