import React from "react";
import "../../../common.css";
import "./dropdown-button.css";
import Chevron from "./chevron.svg";

interface DropDownButtonProps {
  text: string;
  handleOpen: () => void;
  showChevron?: boolean;
  showGradient?: boolean;
  color: string;
}

const DropDownButton = ({
  text,
  handleOpen,
  color,
  showChevron = true,
  showGradient = false,
}: DropDownButtonProps) => {
  function getGradientColor(color) {
    const transparentColor =
      color === "black" ? "rgba(0, 0, 0, 0)" : "rgba(255, 255, 255, 0)";
    return `linear-gradient(-45deg, ${color}, ${transparentColor})`;
  }

  const style = {
    background: showGradient ? getGradientColor(color) : color,
  };

  return (
    <>
      <button className="dropdown-button" onClick={handleOpen} style={style}>
        <div className="row">
          {text}
          {showChevron && (
            <img src={Chevron} alt="Chevron" className="chevron-icon" />
          )}
        </div>
      </button>
    </>
  );
};

export default DropDownButton;
