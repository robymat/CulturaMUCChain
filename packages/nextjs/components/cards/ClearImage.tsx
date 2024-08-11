import React from "react";

export default function ClearImage(props: any) {
  const { imageUri, title, description } = props;
  return (
    <div className="card card-compact bg-base-100 w-96 shadow-xl">
      <figure>
        <img src={imageUri} alt="Shoes" />
      </figure>
      <div className="card-body">
        <h2 className="card-title">{title}</h2>
        <p>{description}</p>
        <div className="card-actions justify-end">
          <button className="btn btn-primary">Donar</button>
        </div>
      </div>
    </div>
  );
}
