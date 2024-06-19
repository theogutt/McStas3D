import React, { useState, useRef, useEffect } from "react";
import "../../../common.css";
import "./color-picker.css";
import Sketch from "@uiw/react-color-sketch";
import DropDownButton from "../dropdown-button/DropDownButton";
import { Component } from "../../../model/Component";

interface ColorPickerProps {
  currentComponent: Component;
  setCurrentComponent: React.Dispatch<React.SetStateAction<Component>>;
  components: Component[];
  setComponents: React.Dispatch<React.SetStateAction<Component[]>>;
}

const ColorPicker = ({
  currentComponent,
  setCurrentComponent,
  components,
  setComponents,
}: ColorPickerProps) => {
  const [open, setOpen] = useState(false);
  const [tempColor, setTempColor] = useState(currentComponent.color);
  const [tempTransparency, setTempTransparency] = useState(
    currentComponent.transparency
  );
  const sketchRef = useRef<HTMLDivElement>(null);

  const handleOpen = () => {
    setOpen(!open);
  };

  const handleChange = (newShade) => {
    setTempColor(newShade.hex);
    setTempTransparency(newShade.rgba.a);
  };

  const handleClickOutside = (event) => {
    console.log("click outside component.id = ", currentComponent.id);
    if (sketchRef.current && !sketchRef.current.contains(event.target)) {
      const newComponents = components.map((c) => {
        if (c.id === currentComponent.id) {
          return { ...c, color: tempColor, transparency: tempTransparency };
        }
        return c;
      });
      setComponents(newComponents);
      setCurrentComponent((prevComponent) => ({
        ...prevComponent,
        color: tempColor,
        transparency: tempTransparency,
      }));
      setOpen(false);
    }
  };

  useEffect(() => {
    if (open) {
      document.addEventListener("mousedown", handleClickOutside);
    } else {
      document.removeEventListener("mousedown", handleClickOutside);
    }
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [open, tempColor, tempTransparency]);

  return (
    <div id="color-picker" className="row" ref={sketchRef}>
      {!open ? (
        <DropDownButton
          text=""
          showGradient={true}
          color={currentComponent.color}
          showChevron={false}
          handleOpen={handleOpen}
        />
      ) : null}
      {open ? (
        <div className="color-picker-background">
          <Sketch color={currentComponent.color} onChange={handleChange} />
        </div>
      ) : null}
    </div>
  );
};

export default ColorPicker;
