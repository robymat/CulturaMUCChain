import React from "react";

function Carousel() {
  return (
    <>
      <div className="carousel w-full">
        <div id="item1" className="carousel-item w-full">
          <img src="https://gateway.pinata.cloud/ipfs/QmXugbyyRyRquefZBs5QGRPVWj9mWqKwkBP2vkCehURSPb" className="w-full" />
        </div>
      </div>
      <div className="flex w-full justify-center gap-2 py-2">
        <a href="#item1" className="btn btn-xs">
          
        </a>
        <a href="#item2" className="btn btn-xs">
          
        </a>
        <a href="#item3" className="btn btn-xs">
          
        </a>
        <a href="#item4" className="btn btn-xs">
          
        </a>
      </div>
    </>
  );
}

export default Carousel;
